Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]

  resources :bands do
      member do
        resources :albums, only: [:new]
      end
    end

  resources :albums, only: [:create, :edit, :show, :update, :destroy] do
    member do
      resources :tracks, only: [:new]
    end
  end

  resources :tracks, only: [:create, :edit, :show, :update, :destroy]

  resource :session, only: [:new, :create, :destroy]

  root to: "bands#index"
end
