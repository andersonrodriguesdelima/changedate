Rails.application.routes.draw do
  root 'home#index'
  post "/resolver" => "home#resolver"
  resources :home
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
