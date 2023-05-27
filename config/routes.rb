Rails.application.routes.draw do

  # 顧客用
  # moduleで、URLを変更せず、ファイル構成だけ指定のパスにする。
  # URL /users/sign_in ...

  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in',as: 'guest_sign_in'
  end

  devise_for :users,skip: [:passwords], controllers: {

    registrations: "public/registrations",
    sessions: 'public/sessions'

  }

  scope module: :public do
    # トップページ　初期表示
    root to: 'homes#top'
    # アバウトページ
    get 'about' => 'homes#about', as: 'about'

    # マイページ
    get 'users/my_page' => 'users#my_page', as: 'my_page'
    # プロフィール編集画面
    get 'users/information/edit'=> 'users#edit', as: 'edit_information_users'
    # プロフィール更新
    patch 'users/information' => 'users#update', as: 'update_information_users'
    # 退会確認画面
    get 'users/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    # 退会処理
    patch 'users/goodbye' => 'users#goodbye', as: 'goodbye'
    # ユーザー詳細画面
    resources :users, only: [:show] do
      get 'posts'
      get 'comments'
      get 'favorites'
    end

    # 投稿内容一覧（ユーザー投稿全て）
    get 'posts/user_index' => 'posts#user_index', as: 'user_index'
    resources :posts do
      resources :comments, only: [:create,:edit,:update,:destroy]
      resources :favorites, only: [:create, :destroy]
    end

    resources :types, only: [:index, :show]

  end

    # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  # 管理者用
  get 'admin' => 'admin/homes#top', as: 'admin_home_top'

  namespace :admin do

    resources :users, only: [:index, :show, :edit, :update]
    resources :posts, only: [:show, :destroy]
    resources :comments, only: [:index, :destroy]
    resources :types

  end

end
