# frozen_string_literal: true

class DeviseRemote::InstallGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def install_devise
    invoke 'devise:install'
  end

  def generate_model
    invoke 'devise', [name]
  end

  def add_login_to_devise
    invoke 'devise_remote:login_migration', [name]
  end

  def add_ldap_attributes_to_devise
    invoke 'devise_remote:ldap_migration', [name]
  end

  def add_initializer
    template 'devise_remote.erb', 'config/initializers/devise_remote.rb'
  end

  def add_authentication
    controller_path = 'app/controllers/application_controller.rb'
    if File.exist?(controller_path)
      inject_into_file controller_path, after: "class ApplicationController < ActionController::Base\n" do
        <<-'RUBY'
        puts "\t# Added by DeviseRemote to authenticate all incoming requests"
        puts "\tbefore_action :authenticate_user!"
        RUBY
      end
    else
      say_status 'warning', <<-TEXT.strip_heredoc, :yellow
        ApplicationController not found.
        ===============================================================================
          You will need to add the following to one of your controllers:

            before_action :authenticate_user!

          See the Devise's README for more information.
        ===============================================================================
      TEXT
    end
  end
end
