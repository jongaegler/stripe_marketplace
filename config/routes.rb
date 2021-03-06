Rails.application.routes.draw do
  resources :products do
    get 'purchase_success'
    post 'checkout'
  end
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  root 'products#index'
  post 'webhooks', controller: 'webhooks'
end
