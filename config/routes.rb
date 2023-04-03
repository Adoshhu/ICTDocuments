Rails.application.routes.draw do
  devise_for :users
  resources :folders
  resources :subfolders
  root 'page#index'

  resources :users do
    resources :folders do
      resources :subfolders do 
        get '/:id', to: 'subfolders#show', as: 'subfolder_show'
      end
    end
  end

end
