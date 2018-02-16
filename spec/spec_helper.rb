# frozen_string_literal: true

require 'bundler/setup'
require 'rails'
require 'devise_remote'
require 'pry-byebug' unless ENV['TRAVIS']
require 'engine_cart'

EngineCart.load_application!

Dir[File.join(File.dirname(__dir__), 'spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
