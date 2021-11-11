Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'spaces', to: 'spaces#create'
  post 'login', to: 'auth#login'

  namespace :manager do
    # manager routers here
    resources :employees
    resources :coupons, only: [:index, :create]
    patch 'coupons', to: 'coupons#distribute'
  end

  namespace :employee do
    # employee routes here
  end
end
