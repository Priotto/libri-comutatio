Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :books do
    resources :transactions, only: [:create]
    collection do
      get :my
    end
  end

  resources :transactions, only: [:index, :destroy, :update]
end
