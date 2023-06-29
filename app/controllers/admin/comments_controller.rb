class Admin::CommentsController < ApplicationController

  # コントローラーに設定して、ログイン済管理者のみにアクセスを許可する
  before_action :authenticate_admin!

  # コメント一覧
  def index

    # コメント欄30件取得（降順）
    @comments = Comment.page(params[:page]).per(30).order(id: "DESC")

  end

  # コメント削除機能
  def destroy

    # 1件コメント取得
    comments = comment_find_params_id
    # 削除
    comments.destroy
    # フラッシュメッセージ
    notice("コメントを削除しました。")
    # 処理後遷移先
    redirect_to admin_comments_path

  end
end
