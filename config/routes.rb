Rails.application.routes.draw do
  resources :applicants, only: [:create, :update, :show, :new]
  get '/application', :to => 'applicants#show_session'
  resources :funnels, only: [:index]
end
