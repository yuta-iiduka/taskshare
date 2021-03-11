Rails.application.routes.draw do
    root :to => "homes#top"               #topページ
    get "home/about" => "homes#about"     #aboutページ
    get 'search' => 'searches#search'     #検索ページ
    devise_for :users
    resources :users, only: [:index, :show, :edit, :update]
    resources :post_files, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resources :post_comments, only: [:create, :destroy]
    end
end
