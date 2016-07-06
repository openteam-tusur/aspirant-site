require 'sidekiq/web'

Rails.application.routes.draw do

  mount Sidekiq::Web => '/sidekiq'

  namespace :manage do
    root to: 'dashboard#spa'
  end

  root :to => 'application#index'

  get '/(*path)', :to => 'application#index'
end
