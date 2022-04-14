# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    get 'app/install', to: 'insales_apps#install', as: :install
    get 'app/uninstall', to: 'insales_apps#uninstall', as: :uninstall
  end

  scope module: :web do
    root 'account/settings#show'

    get 'auth/callback', to: 'auth#callback', as: :callback
    get 'auth/login', to: 'auth#login', as: :login
    resource :session, only: %i[new create destroy]

    scope module: :account, shallow: true do
      resource :settings, only: %i[show]
    end
  end

  unless Rails.env.production?
    namespace :test do
      resource :session, only: %i[create]
    end
  end
end
