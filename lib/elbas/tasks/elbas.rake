require 'elbas'
include Elbas::Logger

namespace :elbas do
  # e.g. "conductor-production-v26.7.29" — environment plus the release tag
  def ami_name_tag
    @ami_name_tag ||= ['conductor', fetch(:rails_env), release_version].join('-')
  end

  # The release being deployed: `cap production deploy branch=v26.7.29` deploys a
  # tag, so prefer that; on the default branch fall back to the nearest local tag.
  def release_version
    branch = fetch(:branch).to_s
    return branch unless branch.empty? || branch == 'main'

    release = `git describe --tags --abbrev=0 2> /dev/null`.strip
    release.empty? ? env.timestamp.strftime('%Y%m%d%H%M%S') : release
  end

  task :ssh do
    include Capistrano::DSL

    info "SSH commands:"
    env.servers.to_a.each.with_index do |server, i|
      info "    #{i + 1}) ssh #{fetch(:user)}@#{server.hostname}"
    end
  end

  task :deploy do
    fetch(:aws_autoscale_group_names).each do |aws_autoscale_group_name|
      info "Auto Scaling Group: #{aws_autoscale_group_name}"
      asg = Elbas::AWS::AutoscaleGroup.new aws_autoscale_group_name

      info "Creating AMI from a running instance..."
      ami = Elbas::AWS::AMI.create asg.instances.running.sample, environment: fetch(:rails_env)
      ami.tag 'Name', ami_name_tag
      ami.tag 'ELBAS-Deploy-group', asg.name
      ami.tag 'ELBAS-Deploy-id', env.timestamp.to_i.to_s
      info  "Created AMI: #{ami.id} (#{ami_name_tag})"

      info "Updating launch template with the new AMI..."
      launch_template = asg.launch_template.update ami
      info "Updated launch template, new default version = #{launch_template.version}"

      info "Cleaning up old AMIs..."
      ami.ancestors.each do |ancestor|
        info "Deleting old AMI: #{ancestor.id}"
        ancestor.delete
      end

      info "Deployment complete!"
    end
  end
end
