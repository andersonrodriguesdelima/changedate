Rails.application.routes.draw do
  root 'home#index'
  get "/index" => "home#index"
  post "/resultado" => "home#resultado"
  resources :home
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
