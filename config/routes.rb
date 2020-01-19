Rails.application.routes.draw do
  devise_for :users
  root to: "products#index"
  resources :signup, except: [:index, :show] do
    collection do
      get 'step1'
      get 'step2'
      get 'step3'
      post 'create',to:'signup#create'
      get 'done' 
    end
  end
  resources :cards, only: [:show] do
    collection do
      post 'pay/:id', to: 'cards#pay'
      get 'done/:id', to: 'cards#done'
      get 'update/:id', to: 'cards#update'
    end
  end
  resources :products
end
