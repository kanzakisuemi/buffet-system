Rails.application.routes.draw do
  
  root "application#homepage"

  devise_for :users
end
