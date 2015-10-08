source "https://rubygems.org"

gem 'rake'

group :test do
  gem "puppet", ENV['PUPPET_VERSION'] || '~> 3.8.0'
  gem "rspec", "< 3.2.0"
  gem "rspec-puppet", :git => 'https://github.com/rodjek/rspec-puppet.git'
  gem "rspec-puppet-facts"
  gem 'rspec-hiera-puppet'
  gem "puppetlabs_spec_helper"
  gem 'metadata-json-lint'
  gem 'ci_reporter_rspec'
  gem 'simplecov'
  gem 'simplecov-console'

  gem 'puppet-lint-classes_and_types_beginning_with_digits-check'
  gem 'puppet-lint-empty_string-check'
  gem 'puppet-lint-absolute_classname-check'
  gem 'puppet-lint-roles_and_profiles-check'
end

group :development do
  gem "travis"
  gem "travis-lint"
  gem "puppet-blacksmith"
  gem "guard-rake"
end

group :system_tests do
  gem "beaker"
  gem "beaker-rspec"
end
