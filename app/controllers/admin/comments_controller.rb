class Admin::CommentsController < ApplicationController

  before_action :authenticate_admin!

  # コメント一覧
  def index

    @comments = Comment.page(params[:page]).per(30).order(id: "DESC")

  end

  # コメント削除機能
  def destroy

    comments = comment_find_params_id
    comments.destroy
    notice("コメントを削除しました。")
    redirect_to admin_comments_path

  end
end
