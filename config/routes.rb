Rails.application.routes.draw do
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'static_pages#home'
  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      resources :places, only: [ :index ]
      resources :medicines, only: [ :index ]
    end # v1
  end # api
end
