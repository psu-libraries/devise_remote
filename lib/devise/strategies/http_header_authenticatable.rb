# frozen_string_literal: true

# Default strategy for signing in a user, based on their email and password in the database.
module Devise
  module Strategies
    class HttpHeaderAuthenticatable < ::Devise::Strategies::Base
      include DeviseRemote::HttpHeaderAuthenticatableBehavior

      # Called if the user doesn't already have a rails session cookie
      def valid?
        valid_user?(request.headers)
      end

      def authenticate!
        user = remote_user(request.headers)
        if user.present?
          u = User.find_by(login: user)
          if u.nil?
            u = User.create(login: user, email: user)
            u.populate_attributes if u.respond_to?(:populate_attributes)
          end
          success!(u)
        else
          fail!
        end
      end
    end
  end
end
