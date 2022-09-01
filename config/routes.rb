Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get '/autocomplete', to: 'books#autocomplete'
  post '/build', to: 'books#build', as: "book_build" #alterar para get

  resources :books do
    resources :trades, only: [:create]
    collection do
      get :my
    end
  end

  resources :trades, only: %i[index destroy update] do
    resources :reviews, only: %i[index new create]
  end

  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end
  get "teste", to: "pages#teste"
end
