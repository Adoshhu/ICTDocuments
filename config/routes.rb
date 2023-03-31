Rails.application.routes.draw do
  devise_for :users
  resources :folders
  root 'page#index'
  
  resources :users do
    resources :folders, shallow: true do
      resources :subfolders, controller: 'folders', only: [:show, :create, :new]
    end
  end
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
