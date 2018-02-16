# frozen_string_literal: true

require 'rails/generators/active_record'

class DeviseRemote::LoginMigrationGenerator < ActiveRecord::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def add_login_to_devise
    migration_template 'add_login_template.erb',
                       "#{migration_path}/add_login_to_#{table_name}.rb",
                       migration_version: migration_version
  end

  private

    def migration_path
      File.join('db', 'migrate')
    end

    def migration_version
      if Rails.version.start_with?('5')
        "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
      end
    end
end
