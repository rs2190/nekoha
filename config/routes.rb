Rails.application.routes.draw do

  # 顧客用
  # moduleで、URLを変更せず、ファイル構成だけ指定のパスにする。
  # URL /users/sign_in ...

  devise_scope :user do
    # ゲストログイン
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in',as: 'guest_sign_in'
  end

  devise_for :users,skip: [:passwords], controllers: {

    # ユーザー新規登録画面
    registrations: "public/registrations",
    # ログイン画面
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

      # ユーザーの投稿内容一覧
      get 'posts'
      # ユーザーのコメント一覧
      get 'comments'
       # ユーザーのいいね一覧
      get 'favorites'
    end

    # 投稿内容一覧（ユーザー投稿全て）⇒　削除
    # get 'posts/user_index' => 'posts#user_index', as: 'user_index'
    resources :posts do

      # コメント機能
      resources :comments, only: [:create,:edit,:update,:destroy]
      # いいね機能
      resources :favorites, only: [:create, :destroy]
    end

    # ねこずかん（種類一覧）系
    resources :types, only: [:index, :show]

  end

    # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {

    # 管理者ログイン
    sessions: "admin/sessions"
  }

  # 管理者用
  get 'admin' => 'admin/homes#top', as: 'admin_home_top'

  namespace :admin do

    # ユーザー一覧系
    resources :users, only: [:index, :show, :edit, :update]
    # 投稿内容一覧系
    resources :posts, only: [:show, :destroy]
    # コメント一覧系
    resources :comments, only: [:index, :destroy]
    # ねこずかん（種類一覧）系
    resources :types

  end

end
