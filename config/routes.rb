# frozen_string_literal: true

DeviseRemote::Engine.routes.draw do
  get 'logout' => 'sessions#destroy', as: :destroy_user_session
  get 'login' => 'sessions#new', as: :new_user_session_old
  get 'login_session' => 'sessions#new', as: :new_user_session
end
