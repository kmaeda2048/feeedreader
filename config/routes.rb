Rails.application.routes.draw do
  root 'static_pages#welcome'
  resources :feeds
  resources :articles, only: :index do
    get 'starred', on: :collection
  end
end
