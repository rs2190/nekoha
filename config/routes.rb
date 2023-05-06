Rails.application.routes.draw do

  # 顧客用
  # moduleで、URLを変更せず、ファイル構成だけ指定のパスにする。
  scope module: :public do
    # トップページ　初期表示
    root to: 'homes#top'
    # アバウトページ
    get 'about' => 'homes#about', as: 'about'

    # マイページ
    get 'users/my_page' => 'users#show', as: 'my_page'
    # プロフィール編集画面
    get 'users/information/edit'=> 'users#edit', as: 'edit_information_users'
    # プロフィール更新
    patch 'users/information' => 'users#update', as: 'update_information_users'
    # 退会確認画面
    get 'users/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    # 退会処理
    patch 'customers/goodbye' => 'users#goodbye', as: 'goodbye'

  end

  # URL /users/sign_in ...

  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in',as: 'guest_sign_in'
  end

  devise_for :users,skip: [:passwords], controllers: {

    registrations: "public/registrations",
    sessions: 'public/sessions'

  }

    # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  # 管理者用
  get 'admin' => 'admin/homes#top', as: 'admin_home_top'

  namespace :admin do

    # ユーザーステータス更新（有効）
    patch 'users/welcome' => 'users#welcome', as: 'users_welcome'
    # ユーザーステータス更新（退会）
    patch 'users/goodbye' => 'users#goodbye', as: 'users_goodbye'
    resources :users , only: [:index, :show]

  end

end
