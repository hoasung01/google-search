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
  namespace :api do
    namespace :v1 do
      resources :google_search do
        collection do
          get :report
        end
      end
    end
  end
end
