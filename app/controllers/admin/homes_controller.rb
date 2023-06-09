class Admin::HomesController < ApplicationController

  # コントローラーに設定して、ログイン済管理者のみにアクセスを許可する
  before_action :authenticate_admin!

  # トップページ
  def top

    # 投稿モデルから1ページ分（データ30件）取得（降順）
    @posts = Post.page(params[:page]).per(30).order(id: "DESC")

  end
end
