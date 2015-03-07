Rails.application.routes.draw do
  root 'welcome#index'
  get 'sign-up', to: 'registrations#new'
  post 'sign-up', to: 'registrations#create'
  get 'sign-in', to: 'auth#new'
  post 'sign-in', to: 'auth#create'
  get 'sign-out', to: 'auth#destroy'
  resources :cats
end
