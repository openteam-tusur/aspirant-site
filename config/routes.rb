require 'sidekiq/web'

Rails.application.routes.draw do

  mount Sidekiq::Web => '/sidekiq'

  namespace :manage do
    resources :permissions, only: [:create, :destroy]
    resources :dissertation_councils, only: [:create, :destroy, :update, :show]
    resources :people do
      member do
        post :update_order
      end
      collection do
        get :search
        get :directory_search
      end
    end
    resources :posts, only: :destroy
    resources :council_specialities do
      member do
        post :remove_from_council
        post :update_order
      end
      collection do
        get 'search'
      end
    end

    root to: 'dashboard#spa'
    get 'users/search', to: 'users#search', as: :users_search

    %w(get_permissions get_locale_hash get_councils
      get_science_degrees_and_titles get_enumerize_values).each do |route|
      get %Q(angular/#{route}), to: %Q(angular##{route})
    end

  end

  root to: 'application#index'

  get '/(*path)', to: 'application#index'
end
