# frozen_string_literal: true

module DeviseRemote
  class SessionsController < ApplicationController
    # @note Adapted from https://github.com/cosignweblogin/cosign/blob/master/scripts/logout/logout.php
    def destroy
      before_destroy
      cookies.delete(request.env['COSIGN_SERVICE']) if request.env['COSIGN_SERVICE']
      redirect_to(DeviseRemote.destroy_redirect_url)
    end

    def new
      redirect_url = session['user_return_to']
      session['user_return_to'] = nil if redirect_url # clear so we do not get it next time
      webaccess = DeviseRemote.web_access_url
      dashboard = DeviseRemote.new_session_redirect_url
      redirect_to webaccess + '&' + (redirect_url.blank? ? dashboard : redirect_url)
    end

    # @note Preprend a module to this controller in order to override this method in your
    #   local application for additions such as expiring local sessions, etc.
    def before_destroy; end
  end
end
