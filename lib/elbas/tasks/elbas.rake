require 'elbas'
include Elbas::Logger

namespace :elbas do
  # The baked AMI's Name tag. Configurable:
  #
  #   set :elbas_ami_name, 'my-name'                    # literal
  #   set :elbas_ami_name, -> { "app-#{fetch(:rails_env)}" }  # resolved at bake time
  #
  # Default: "<application>-<rails_env>-<release>", e.g.
  # "conductor-production-v26.7.29".
  def ami_name_tag
    @ami_name_tag ||= begin
      configured = fetch(:elbas_ami_name, nil)
      if configured.respond_to?(:call)
        configured.call.to_s
      elsif configured
        configured.to_s
      else
        [fetch(:application, 'app'), fetch(:rails_env), release_version].join('-')
      end
    end
  end

  # Extra tags for the baked AMI, merged after the Name and ELBAS bookkeeping
  # tags (so they can override Name if desired):
  #
  #   set :elbas_ami_tags, { 'Team' => 'web', 'Release' => -> { fetch(:branch) } }
  def ami_extra_tags
    fetch(:elbas_ami_tags, {}).transform_values do |value|
      (value.respond_to?(:call) ? value.call : value).to_s
    end
  end

  # The AMI's immutable name attribute (not the Name tag). Must be unique per
  # bake — include a timestamp or release if you override it:
  #
  #   set :elbas_ami_image_name, -> { "app-#{fetch(:branch)}-#{Time.now.to_i}" }
  #
  # Default (nil) keeps elbas's "ELBAS-ami-<rails_env>-<epoch>".
  def ami_image_name
    configured = fetch(:elbas_ami_image_name, nil)
    (configured.respond_to?(:call) ? configured.call : configured)&.to_s
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
      ami = Elbas::AWS::AMI.create asg.instances.running.sample,
                                   environment: fetch(:rails_env),
                                   name: ami_image_name
      ami.tag 'Name', ami_name_tag
      ami.tag 'ELBAS-Deploy-group', asg.name
      ami.tag 'ELBAS-Deploy-id', env.timestamp.to_i.to_s
      ami_extra_tags.each { |key, value| ami.tag key.to_s, value }
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
