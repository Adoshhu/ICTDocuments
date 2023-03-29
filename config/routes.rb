Rails.application.routes.draw do
  root 'page#index'
  resources :folders
  devise_for :users

  resources :users do
    resources :folders do
      resources :subfolders, controller: 'folders'
    end
  end

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
