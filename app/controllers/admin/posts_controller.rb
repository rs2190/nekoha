class Admin::PostsController < ApplicationController

  # コントローラーに設定して、ログイン済管理者のみにアクセスを許可する
  before_action :authenticate_admin!

  # 投稿内容詳細画面
  def show

    # 1件投稿情報取得
    @post = post_find_params_id

  end

  # 投稿内容削除処理
  def destroy

    # 1件投稿情報取得
    @post = post_find_params_id
    # 削除
    @post.destroy
    # フラッシュメッセージ
    notice("投稿内容を削除しました。")
    # 処理後遷移先
    redirect_to admin_home_top_path

  end
end
