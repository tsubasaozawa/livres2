Rails.application.routes.draw do
  devise_for :users
  root to: "products#index"
  resources :products do
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
    member do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end

    member do
      post 'image_destroy', defaults: { format: 'json' }
    end
  end

  resources :signup, except: [:index, :show] do
    collection do
      get 'step1'
      get 'step2'
      get 'step3'
      post 'create',to:'signup#create'
      get 'done' 
    end
  end
  resources :users, only: [:show, :edit, :update] do
    get 'users/:name', controller: 'users', action: 'edit'
    member do
      get :bought_products
      get :sold_products
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
