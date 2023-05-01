Rails.application.routes.draw do

  # 顧客用
  # moduleで、URLを変更せず、ファイル構成だけ指定のパスにする。
  scope module: :public do
    # トップページ　初期表示
    root to: 'homes#top'
    # アバウトページ
    get 'about' => 'homes#about', as: 'about'
  end

  # URL /users/sign_in ...
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

end
