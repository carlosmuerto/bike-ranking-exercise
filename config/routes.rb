Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      scope '/rankings' do
        get '/actual', to: 'rankings#index_by_actual', defaults: { format: :json }
        get ':year/:month', to: 'rankings#index_by_year_and_month', defaults: { format: :json }
        get ':year', to: 'rankings#index_by_year', defaults: { format: :json }
      end

      resources :records, defaults: {format: :json}
      resources :users, defaults: {format: :json} do
        post '/login', to: 'users#login', on: :collection, defaults: {format: :json}
        post '/logout', to: 'users#logout', on: :collection, defaults: {format: :json}
        post '/current_user', to: 'users#current', on: :collection, defaults: {format: :json}
        get '/records', to: 'records#index_with_user', defaults: {format: :json}
      end
    end
  end
end
