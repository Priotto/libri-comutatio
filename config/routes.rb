Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :books do
    resources :transactions, only: [:create]
    collection do
      get :my
    end
  end

  resources :transactions, only: %i[index destroy update]

  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end
end
