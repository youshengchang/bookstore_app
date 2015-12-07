Rails.application.routes.draw do
  root to: "catalogs#index"
  resources :authors
  resources :publishers
  resources :books
end
