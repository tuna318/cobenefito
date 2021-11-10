Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'spaces', to: 'spaces#create'
  post 'login', to: 'auth#login'

  namespace :manager do
    # manager routers here
  end

  namespace :employee do
    # employee routes here
  end
end
