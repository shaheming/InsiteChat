Rails.application.routes.draw do
  get '/users' => "users#index"
 mount ActionCable.server => '/cable'
  devise_for :users
  root "users#index"
  resources :friends do
    member do
      post :add
    end
  end

  resources :conversations, only: [:create] do
    resources :messages, only: [:index, :create,:destroy]
  end
end
