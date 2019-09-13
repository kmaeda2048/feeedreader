Rails.application.routes.draw do
  root 'static_pages#welcome'
  resources :feeds
  resources :articles, only: :update do
    get 'unread', on: :collection
    get 'starred', on: :collection
  end
end
