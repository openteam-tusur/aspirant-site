require 'sidekiq/web'

Rails.application.routes.draw do

  mount Sidekiq::Web => '/sidekiq'

  namespace :manage do
    resources :permissions, only: [:create, :destroy, :index]
    resources :dissertation_councils, except: [:edit, :new]
    resources :posts, only: [:update, :destroy]
    resources :file_copies, only: [:create, :update, :destroy]

    resources :adverts, path: :announcements, only: [:index, :show, :create, :update, :destroy] do
      member do
        get  :versions
        post :publish
        post :unpublish
      end
    end

    resources :people, only: [:create, :update, :index, :show] do
      member do
        post :update_order
        post :remove_from_advert
      end

      collection do
        get :search
        get :directory_search
      end
    end

    resources :council_specialities, only: [:index, :create, :update, :show] do
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
      get_science_degrees_and_titles get_current_user_info).each do |route|
        get %Q(angular/#{route}), to: %Q(angular##{route})
    end

  end

  get 'ru/dissertatsionnye-sovety', to: 'dissertation_councils#index', as: :dissertion_councils
  get '/ru/ob-yavleniya-o-zaschitah-dissertatsiy', to: 'adverts#index', as: :adverts
  get '/ru/ob-yavleniya-o-zaschitah-dissertatsiy(/:id)', to: 'adverts#show', as: :advert

  root to: 'application#index'

  get '/(*path)', to: 'application#index'
end
