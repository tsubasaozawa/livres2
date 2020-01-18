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
end
