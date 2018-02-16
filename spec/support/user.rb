# frozen_string_literal: true

class User < ActiveRecord::Base
end

RSpec.configure do |config|
  config.before do
    User.destroy_all
  end
end
