Rails.application.routes.draw do
  devise_for :users
  #resources :tasks
  #get 'projects/destroy'

devise_scope :user do  
  root "projects#index"
  resources :projects do 
    resources :votes
    resources :tasks
  end
end
#root 'devise/sessions#new', as: :unauthenticated_root
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
