Rails.application.routes.draw do
  
  root "application#homepage"
  
  resources :buffets, only: %i[index new create show edit update]
  resources :event_types, only: %i[index new create edit update destroy]
  devise_for :users
end
