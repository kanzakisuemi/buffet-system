Rails.application.routes.draw do
  
  root "application#homepage"
  
  resources :buffets, only: %i[index new create show edit update] do
    get 'event_selection', on: :member
    get 'event_types', on: :member
    post 'archive', on: :member
    post 'unarchive', on: :member
  end
  resources :event_types, only: %i[new create edit update] do
    resources :orders, only: %i[new create]
    delete :remove_picture, on: :member
    post 'archive', on: :member
    post 'unarchive', on: :member
  end
  resources :orders, only: %i[index show edit update] do
    resources :messages, only: %i[index create] do
      get 'start_chat', on: :collection
    end
    get 'my', on: :collection
    post 'confirmed', on: :member
    post 'canceled', on: :member
  end
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :buffets, only: %i[index show] do
        get 'event_types', on: :member
      end
      resources :event_types, only: %i[] do
        get 'available', on: :member
      end
    end
  end
end
