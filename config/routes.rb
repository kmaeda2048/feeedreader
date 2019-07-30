Rails.application.routes.draw do
  resources :articles, only: [:index, :show, :edit, :update]
  resources :feeds
  root to: 'static_pages#welcome'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
