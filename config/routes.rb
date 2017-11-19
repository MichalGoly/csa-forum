# Defines the app's routes
# @author Chris Loftus
Rails.application.routes.draw do
  resources :users do
    # We add a special route to support the search field
    get 'search', on: :collection
  end

  # the REST API routes
  namespace :api, defaults: {format: :json} do
    resources :users, except: [:new, :edit] do
      get 'search', on: :collection
    end
    resources :topics, except: [:new, :edit]
  end

  # No point allowing the editing or update of an existing broadcast
  resources :broadcasts, except: [:edit, :update]

  # A singleton resource and so no paths requiring ids are generated
  # Also, don't want to support editing of the session
  resource :session, only: [:new, :create, :destroy]

  # This is just to support the landing page
  get 'home', to: 'home#index', as: :home

  resources :topics, except: [:edit, :update]

  # no point showing all posts in a separate page or showing specific posts
  resources :posts, except: [:index, :show, :edit]

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
