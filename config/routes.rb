require 'sidekiq/web'

Rails.application.routes.draw do

  mount Sidekiq::Web => '/sidekiq'

  namespace :manage do
    resources :permissions, only: [:create, :destroy]
    resources :dissertation_councils, only: [:create, :destroy, :update, :show]

    root to: 'dashboard#spa'
    get 'users/search', to: 'users#search', as: :users_search
    get 'users/persons_search', to: 'users#persons_search', as: :persons_search
    get 'users/directory_search', to: 'users#directory_search', as: :directory_search

    %w(get_permissions get_locale_hash get_councils
      get_science_degrees_and_titles).each do |route|
      get %Q(angular/#{route}), to: %Q(angular##{route})
    end

  end

  root to: 'application#index'

  get '/(*path)', to: 'application#index'
end
