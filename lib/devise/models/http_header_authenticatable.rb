# frozen_string_literal: true

module Devise
  module Models
    module HttpHeaderAuthenticatable
      extend ActiveSupport::Concern

      def after_database_authentication; end
    end
  end
end
