# frozen_string_literal: true

require 'rails/generators'

class TestAppGenerator < Rails::Generators::Base
  source_root './spec/test_app_templates'

  def install_engine
    invoke 'devise_remote:install', ['User']
  end
end
