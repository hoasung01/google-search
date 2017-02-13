Rails.application.routes.draw do
  devise_for :users
  root to: 'visitors#index'
  namespace :api do
    namespace :v1 do
    end
  end
end
