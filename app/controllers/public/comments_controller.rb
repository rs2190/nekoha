class Public::CommentsController < ApplicationController

  # コメント登録処理
  def create

    # # 投稿モデル取得
    # @post = Post.find(params[:post_id])
    # データを受け取り新規登録するためのインスタンス作成
    comment = current_user.comments.new(comment_params)
    # コメント.ユーザーID = ログインしているユーザーID
    comment.user_id = current_user.id
    # コメント.投稿ID = 取得した投稿.id
    comment.post_id = params[:post_id]
    # コメント登録
    comment.save

    # 遷移先
    redirect_to post_path(params[:post_id])

  end

  # コメント編集画面
  def edit

    @comment = comment_find_params_id

  end

  # コメント更新処理
  def update

    @comment = comment_find_params_id

    if @comment.update(comment_params)

      notice("コメントを更新しました。")
      redirect_to post_path(@comment.post_id)

    else

      render :edit

    end

  end

  # コメント削除処理
  def destroy

    @comment = comment_find_params_id
    post_id = @comment.post_id
    @comment.destroy
    notice("コメントを削除しました。")
    redirect_to post_path(post_id)

  end

  # ストロングパラメータ
  def comment_params
    params.require(:comment).permit(:comment_word)
  end

end
