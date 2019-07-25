Rails.application.routes.draw do
  get 'articles/index'
  get 'articles/show'
  get 'articles/edit'
  resources :feeds
  root to: 'static_pages#welcome'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
