Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :records
      resources :users do
        get '/records', to: 'records#index_with_user'
      end
    end
  end
end
