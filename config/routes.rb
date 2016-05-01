Rails.application.routes.draw do
  root "commuters#show"
  resources :commuters, only: [:index, :show]
end
