Rails.application.routes.draw do
 get 'map', to: 'map#index', as: 'custom_map'

 # resources :maps, only: [:index]
  
  root 'pages#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
