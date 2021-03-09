Rails.application.routes.draw do
    root :to => "homes#top"
    get "home/about" => "homes#about"
    devise_for :users
    resources :users, only: [:index, :show, :edit, :update]
    resources :post_files, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
        member do
          get :download
        end
    end
end
