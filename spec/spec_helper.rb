# configure Rails Envinronment
ENV['RAILS_ENV'] = 'test'
require 'simplecov'
SimpleCov.start do
  add_filter 'spec/'
end

require File.expand_path('../dummy/config/environment.rb',  __FILE__)

require 'rspec/rails'
require 'rspec/its'
require 'factory_girl_rails'

ENGINE_RAILS_ROOT = File.join(File.dirname(__FILE__), '../')

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.expand_path(File.join(ENGINE_RAILS_ROOT, 'spec/support/**/*.rb'))].each { |f| require f }

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.alias_it_should_behave_like_to :it_has_behavior, 'has behavior:'

  # Use a focus tag to filter specific specs. This helps if you need to
  # focus on one spec instead of the whole suite.
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  # Filter slow specs. Add a :slow tag to the spec to keep it from
  # running unless the SLOW_SPECS environment variable is set.
  # config.filter_run_excluding :slow unless ENV['SLOW_SPECS']

  config.before(:each) do
    DatastaxRails::Base.recorded_classes = {}
    DatastaxRails::Base.statement_cache.clear
  end

  config.after(:each) do
    DatastaxRails::Base.recorded_classes.keys.each do |klass|
      DatastaxRails::Base.connection.execute("TRUNCATE #{klass.column_family}")
    end
  end

  # config.after(:all) do
  # DatastaxRails::Base.models.each do |m|
  # DatastaxRails::Cql::Truncate.new(m).execute
  # end
  # end
end
