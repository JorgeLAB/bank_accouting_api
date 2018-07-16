Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :accounts, only: [] do
        resources :transfers, only: :create
      end
    end
  end
end
