Rails.application.routes.draw do
  
  root "application#homepage"
  
  resources :buffets, only: %i[index new create show edit update] do
    get 'event_selection', on: :member
    get 'event_types', on: :member
  end
  resources :event_types, only: %i[new create edit update] do
    resources :orders, only: %i[new create]
    delete :remove_picture, on: :member
  end
  resources :orders, only: %i[index show edit update] do
    get 'my', on: :collection
    post 'confirmed', on: :member
    post 'canceled', on: :member
  end
  devise_for :users, controllers: { registrations: 'users/registrations' }
end
