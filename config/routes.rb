Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  devise_for :employees
  
  resources :account_activities
  resources :accounts
  resources :licenses
  resources :software_versions
  resources :devices
  resources :cameras
  resources :employees
  
  root 'welcome#index'
end
