Rails.application.routes.draw do
  get '/users' => "users#index"

  devise_for :users
  root "friends#index"
  resources :friends do
    member do
      post :add
    end
  end

end
