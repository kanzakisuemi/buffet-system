Rails.application.routes.draw do
  
  root "application#homepage"
  
  resources :buffets, only: %i[index new create show edit update]
  resources :event_types, only: %i[index new create edit update]
  resources :event_types do
    member do
      delete :remove_picture
    end
  end
  devise_for :users
end
