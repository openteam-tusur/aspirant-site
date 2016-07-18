require 'sidekiq/web'

Rails.application.routes.draw do

  mount Sidekiq::Web => '/sidekiq'

  namespace :manage do
    resources :permissions, only: [:create, :destroy, :index]
    resources :dissertation_councils, except: [:edit, :new]
    resources :posts, only: :destroy
    resources :adverts, only: [:update, :show, :index]

    resources :people, only: [:create] do
      member do
        post :update_order
        post :remove_from_advert
      end
      collection do
        get :search
        get :directory_search
      end
    end

    resources :council_specialities, only: [:create] do
      member do
        post :remove_from_council
        post :update_order
      end
      collection do
        get :search
      end
    end

    root to: 'dashboard#spa'
    get 'users/search', to: 'users#search', as: :users_search

    %w(get_permissions get_locale_hash get_enumerize_values
      get_science_degrees_and_titles).each do |route|
        get %Q(angular/#{route}), to: %Q(angular##{route})
    end

  end

  get 'ru/dissertatsionnye-sovety', to: 'dissertation_councils#index', as: :dissertion_councils

  root to: 'application#index'

  get '/(*path)', to: 'application#index'
end
