Rails.application.routes.draw do
  devise_for :users
  root to: 'visitors#index'
  resources :visitors, only: [] do
    get 'report', on: :collection
  end
  resources :gg_search, only: [] do
    post 'upload_csv', on: :collection
  end
  namespace :api do
    namespace :v1 do
    end
  end
end
