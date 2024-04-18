Rails.application.routes.draw do
  
  root "application#homepage"
  
  resources :buffets, only: %i[index new create show edit update]
  devise_for :users
end
