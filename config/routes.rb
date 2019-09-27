Rails.application.routes.draw do
  root 'static_pages#welcome'
  resources :feeds, except: :show do
    get 'unread', on: :member
  end
  resources :articles, only: :update do
    get 'unread', on: :collection
    get 'starred', on: :collection
  end
  get 'shortcuts', to: 'static_pages#shortcuts'
end
