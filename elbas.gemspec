# -*- encoding: utf-8 -*-
# stub: elbas 3.0.4 ruby lib

Gem::Specification.new do |s|
  s.name = "elbas".freeze
  s.version = "3.0.4".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Logan Serman".freeze]
  s.date = "1980-01-02"
  s.description = "Capistrano plugin for deploying to AWS AutoScale Groups.".freeze
  s.email = ["loganserman@gmail.com".freeze]
  s.files = [".gitignore".freeze, ".rspec".freeze, ".travis.yml".freeze, "Gemfile".freeze, "LICENSE.txt".freeze, "README.md".freeze, "Rakefile".freeze, "elbas.gemspec".freeze, "lib/elbas.rb".freeze, "lib/elbas/aws/ami.rb".freeze, "lib/elbas/aws/autoscale_group.rb".freeze, "lib/elbas/aws/base.rb".freeze, "lib/elbas/aws/instance.rb".freeze, "lib/elbas/aws/instance_collection.rb".freeze, "lib/elbas/aws/launch_template.rb".freeze, "lib/elbas/aws/snapshot.rb".freeze, "lib/elbas/aws/taggable.rb".freeze, "lib/elbas/capistrano.rb".freeze, "lib/elbas/errors/no_launch_template.rb".freeze, "lib/elbas/logger.rb".freeze, "lib/elbas/retryable.rb".freeze, "lib/elbas/tasks/elbas.rake".freeze, "lib/elbas/version.rb".freeze, "spec/aws/ami_spec.rb".freeze, "spec/aws/autoscale_group_spec.rb".freeze, "spec/aws/instance_collection_spec.rb".freeze, "spec/aws/instance_spec.rb".freeze, "spec/aws/launch_template_spec.rb".freeze, "spec/aws/taggable_spec.rb".freeze, "spec/capistrano_spec.rb".freeze, "spec/spec_helper.rb".freeze, "spec/support/stubs/CreateImage.200.xml".freeze, "spec/support/stubs/CreateLaunchConfiguration.200.xml".freeze, "spec/support/stubs/CreateLaunchTemplateVersion.200.xml".freeze, "spec/support/stubs/CreateTags.200.xml".freeze, "spec/support/stubs/DeleteLaunchConfiguration.200.xml".freeze, "spec/support/stubs/DeleteSnapshot.200.xml".freeze, "spec/support/stubs/DeregisterImage.200.xml".freeze, "spec/support/stubs/DescribeAutoScalingGroups.200.xml".freeze, "spec/support/stubs/DescribeImages.200.xml".freeze, "spec/support/stubs/DescribeInstances.200.xml".freeze, "spec/support/stubs/DescribeInstances_Empty.200.xml".freeze, "spec/support/stubs/DescribeInstances_MultipleReservations.200.xml".freeze, "spec/support/stubs/DescribeInstances_MultipleRunning.200.xml".freeze, "spec/support/stubs/DescribeLaunchConfigurations.200.xml".freeze, "spec/support/stubs/DescribeSnapshots.200.xml".freeze, "spec/support/stubs/DescribeTags.200.xml".freeze, "spec/support/stubs/UpdateAutoScalingGroup.200.xml".freeze, "spec/support/stubs/security-credentials.200.json".freeze]
  s.homepage = "https://github.com/lserman/capistrano-elbas".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.6.9".freeze
  s.summary = "Capistrano plugin for deploying to AWS AutoScale Groups.".freeze
  s.test_files = ["spec/aws/ami_spec.rb".freeze, "spec/aws/autoscale_group_spec.rb".freeze, "spec/aws/instance_collection_spec.rb".freeze, "spec/aws/instance_spec.rb".freeze, "spec/aws/launch_template_spec.rb".freeze, "spec/aws/taggable_spec.rb".freeze, "spec/capistrano_spec.rb".freeze, "spec/spec_helper.rb".freeze, "spec/support/stubs/CreateImage.200.xml".freeze, "spec/support/stubs/CreateLaunchConfiguration.200.xml".freeze, "spec/support/stubs/CreateLaunchTemplateVersion.200.xml".freeze, "spec/support/stubs/CreateTags.200.xml".freeze, "spec/support/stubs/DeleteLaunchConfiguration.200.xml".freeze, "spec/support/stubs/DeleteSnapshot.200.xml".freeze, "spec/support/stubs/DeregisterImage.200.xml".freeze, "spec/support/stubs/DescribeAutoScalingGroups.200.xml".freeze, "spec/support/stubs/DescribeImages.200.xml".freeze, "spec/support/stubs/DescribeInstances.200.xml".freeze, "spec/support/stubs/DescribeInstances_Empty.200.xml".freeze, "spec/support/stubs/DescribeInstances_MultipleReservations.200.xml".freeze, "spec/support/stubs/DescribeInstances_MultipleRunning.200.xml".freeze, "spec/support/stubs/DescribeLaunchConfigurations.200.xml".freeze, "spec/support/stubs/DescribeSnapshots.200.xml".freeze, "spec/support/stubs/DescribeTags.200.xml".freeze, "spec/support/stubs/UpdateAutoScalingGroup.200.xml".freeze, "spec/support/stubs/security-credentials.200.json".freeze]

  s.installed_by_version = "3.6.9".freeze

  s.specification_version = 4

  s.add_development_dependency(%q<bundler>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<byebug>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rake>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rspec>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<webmock>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<webmock-rspec-helper>.freeze, [">= 0".freeze])
  s.add_runtime_dependency(%q<aws-sdk-autoscaling>.freeze, ["~> 1".freeze])
  s.add_runtime_dependency(%q<aws-sdk-ec2>.freeze, ["~> 1".freeze])
  s.add_runtime_dependency(%q<capistrano>.freeze, ["> 3".freeze])
end
