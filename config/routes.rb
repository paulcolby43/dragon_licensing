Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  resources :account_activities
  resources :accounts
  resources :licenses
  resources :software_versions
  
  root 'welcome#index'
end
