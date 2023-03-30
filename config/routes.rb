Rails.application.routes.draw do
  resources :users do
    resources :folders do
      resources :subfolders, controller: 'folders', only: [:create, :new]
    end
  end
  root 'page#index'
  resources :folders
  devise_for :users

 

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
