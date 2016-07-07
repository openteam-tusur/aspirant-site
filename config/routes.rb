require 'sidekiq/web'

Rails.application.routes.draw do

  mount Sidekiq::Web => '/sidekiq'

  namespace :manage do
    resources :permissions, only: [:create, :destroy]
    root to: 'dashboard#spa'
    get 'users/search', to: 'users#search', as: :users_search

    %w(get_permissions get_locale_hash).each do |route|
      get %Q(angular/#{route}), to: %Q(angular##{route})
    end

  end

  root to: 'application#index'

  get '/(*path)', to: 'application#index'
end
