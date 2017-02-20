Rails.application.routes.draw do
  devise_for :users
  root to: 'visitors#index'
  resources :visitors, only: [] do
    collection do
      get :report
      post :upload_csv
      get :query
    end
  end
  resources :gg_search, only: [] do
  end
  namespace :api do
    namespace :v1 do
    end
  end
end
