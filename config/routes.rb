Rails.application.routes.draw do
    root :to => "homes#top"               #topページ
    get "home/about" => "homes#about"     #aboutページ
    get 'search' => 'searches#search'     #検索結果ページ
    devise_for :users
    resources :users, only: [:index, :show, :edit, :update] do
      get :favorites, on: :member     #お気に入りページ
      resources :events, only: [:index, :show, :edit, :update, :destroy]
    end
    resources :post_files, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resource :favorites, only: [:create, :destroy]        #お気に入り機能
      resources :post_comments, only: [:create, :destroy]   #コメント機能
      get :sort_favorited, on: :collection #お気に入り数ランキングページ
      get :sort_commented, on: :collection #コメント数ランキングページ
    end
end
