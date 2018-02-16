# frozen_string_literal: true

require 'devise_remote/version'
require 'devise'

module DeviseRemote
  autoload :HttpHeaderAuthenticatableBehavior, 'devise_remote/http_header_authenticatable_behavior'
end

module Devise
  module Models
    autoload :HttpHeaderAuthenticatable, 'devise/models/http_header_authenticatable'
  end

  module Strategies
    autoload :HttpHeaderAuthenticatable, 'devise/strategies/http_header_authenticatable'
  end
end
