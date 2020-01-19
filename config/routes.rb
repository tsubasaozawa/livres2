Rails.application.routes.draw do
  devise_for :users
  root to: "products#index"
  resources :products
  resources :signup, except: [:index, :show] do
    collection do
      get 'step1'
      get 'step2'
      get 'step3'
      post 'create',to:'signup#create'
      get 'done' 
    end
  end
  resources :purchase, only: [:show] do
    collection do
      post 'pay/:id', to: 'purchase#pay'
      get 'done/:id', to: 'purchase#done'
      get 'update/:id', to: 'purchase#update'
    end
  end

  resources :cards, only: [:new, :show] do
    member do
      post :pay
      post :delete
    end
  end
end
