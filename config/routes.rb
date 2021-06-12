Rails.application.routes.draw do
  get 'login/login'
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :search
      resources :count
      resources :dnscheck
      resources :optout
      resources :sites
      resources :softwares
      resources :all_sites
    end
  end
  post 'login/login'
end
