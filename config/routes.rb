Rails.application.routes.draw do
  devise_for :users
  root to: 'visitors#index'
  resources :gg_search, only: [] do
    post 'upload_csv', on: :collection
  end
  namespace :api do
    namespace :v1 do
    end
  end
end
