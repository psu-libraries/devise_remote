# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DeviseRemote::SessionsController, type: :routing do
  describe 'routing' do
    it 'sends /logout to sessions#destroy' do
      expect(get: '/logout').to route_to(controller: 'devise_remote/sessions', action: 'destroy')
      expect(destroy_user_session_path).to eq('/devise_remote/logout')
    end
    it 'sends /login to sessions#new' do
      expect(get: '/login_session').to route_to(controller: 'devise_remote/sessions', action: 'new')
      expect(new_user_session_path).to eq('/devise_remote/login_session')
    end
  end
end
