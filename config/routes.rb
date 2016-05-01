Rails.application.routes.draw do
  root "commuters#index"
  resources :commuters, only: [:index, :show]
  resources :stops, only: [:show]
end
