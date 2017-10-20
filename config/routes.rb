Rails.application.routes.draw do
  root 'products#index'
  resources :products
  get 'cart', to: 'cart#show'
  post 'cart', to: 'cart#add_product'
  delete 'cart', to: 'cart#remove_product'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
