# frozen_string_literal: true

require 'devise_remote/engine'
require 'devise_remote/version'
require 'devise'

module DeviseRemote
  autoload :HttpHeaderAuthenticatableBehavior, 'devise_remote/http_header_authenticatable_behavior'

  class << self
    attr_accessor :destroy_redirect_url, :new_session_redirect_url, :web_access_url
  end

  # @note Mimics the same configuration process with Devise
  def self.setup
    yield self
  end
end

module Devise
  module Models
    autoload :HttpHeaderAuthenticatable, 'devise/models/http_header_authenticatable'
  end

  module Strategies
    autoload :HttpHeaderAuthenticatable, 'devise/strategies/http_header_authenticatable'
  end
end
