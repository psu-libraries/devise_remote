# frozen_string_literal: true

# Shared behavior for determining if a user is valid based on the headers passed
# into the Rails application from the authenticating service. At Penn State, this
# typically happens via WebAccess. Once the user is authenticated, the user's
# network id (ex. abc123) is passed to the Passenger instance running the Rails
# application as an HTTP header. This module reads the headers to determine
# if there is a valid user present.
#
# We can include this module in controllers to determine if user's are valid. This
# is useful when making a public versus authenticated decision.
#
# @example
#   class ApplicationController < ActionController::Base
#     include Devise::Remote::HttpHeaderAuthenticatableBehavior
#   end

module DeviseRemote
  module HttpHeaderAuthenticatableBehavior
    # @param [Hash] headers from ActionDispatch::Request#headers
    # @return [Boolean]
    # @note Called if the user doesn't already have a rails session cookie
    def valid_user?(headers)
      remote_user(headers).present?
    end

    protected

      # @note In production, only check for REMOTE_USER. HTTP_ is removed from the variable before
      #   it is passed to the application. In test or development, this may or may not
      #   happen depending on the setup or testing framework, so we allow both. This allows for
      #   ModHeader and other browser plugins to be used in development mode.
      def remote_user(headers)
        if Rails.env.production?
          headers.fetch('REMOTE_USER', nil)
        else
          headers.fetch('REMOTE_USER', nil) || headers.fetch('HTTP_REMOTE_USER', nil)
        end
      end
  end
end
