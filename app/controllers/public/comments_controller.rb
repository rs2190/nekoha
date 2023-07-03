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

    # 処理後遷移先
    redirect_to post_path(params[:post_id])

  end

  # コメント編集画面
  def edit

    # 1件コメント取得
    @comment = comment_find_params_id

  end

  # コメント更新処理
  def update

    # 1件コメント取得
    @comment = comment_find_params_id

    # 更新時チェック
    if @comment.update(comment_params)

      # 成功時処理
      # フラッシュメッセージ
      notice("コメントを更新しました。")
      # 処理後遷移先
      redirect_to post_path(@comment.post_id)

    else

      # 失敗時処理
      # 処理後遷移先
      render :edit

    end

  end

  # コメント削除処理
  def destroy

    # 1件コメント取得
    @comment = comment_find_params_id
    # 取得したコメントモデルから投稿IDを取得
    post_id = @comment.post_id
    # 削除
    @comment.destroy
    # フラッシュメッセージ
    notice("コメントを削除しました。")
    # 処理後遷移先
    redirect_to post_path(post_id)

  end

  # ストロングパラメータ
  def comment_params
    params.require(:comment).permit(:comment_word)
  end

end
