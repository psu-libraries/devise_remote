# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DeviseRemote::SessionsController, type: :controller do
  describe '#destroy' do
    let(:cookie_jar) { instance_double('ActionDispatch::Cookies::CookieJar') }

    before do
      allow(controller).to receive(:cookies).and_return(cookie_jar)
      request.env['COSIGN_SERVICE'] = 'cosign_service'
    end

    it 'redirects to the central logout page and deletes the cookie from the cosign service' do
      expect(cookie_jar).to receive(:delete).with('cosign_service')
      get :destroy
      expect(response).to redirect_to(DeviseRemote.destroy_redirect_url)
    end
  end

  describe '#new' do
    it 'redirects to the central login page' do
      get :new
      expect(response).to redirect_to("#{DeviseRemote.web_access_url}&/")
    end

    context 'when user_return_to is set' do
      it 'does not redirect to the central login page' do
        session['user_return_to'] = 'http://return_to_me'
        get :new
        expect(response).to redirect_to("#{DeviseRemote.web_access_url}&http://return_to_me")
      end
    end
  end
end
