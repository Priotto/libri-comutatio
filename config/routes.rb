Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :books do
    resources :trades, only: [:create]
    collection do
      get :my
    end
  end

  resources :trades, only: %i[index destroy update]

  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end
  get "teste", to: "pages#teste"
end
