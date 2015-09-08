Rails.application.routes.draw do
 
  devise_for :users

  resources :wikis do
     resources :collaborators, only: [:create, :destroy]
  end

  resources :charges, only: [:new, :create]

  get 'welcome/index'

  get 'welcome/about'

  get 'welcome/account'

  get 'users/downgrade'

  root to: 'welcome#index'

end
