Rails.application.routes.draw do
  resources :products do
    post 'purchase'
    post 'checkout'
  end
  devise_for :users, :controllers => { :omniauth_callbacks => 'omniauth_callbacks' }
  root 'products#index'
end
