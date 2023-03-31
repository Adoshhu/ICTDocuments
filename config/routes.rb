Rails.application.routes.draw do
  devise_for :users
  resources :folders
  root 'page#index'

  resources :users do
    resources :folders do
      resources :subfolders, controller: 'folders', only: [:show, :create, :new]
    end
  end

end
