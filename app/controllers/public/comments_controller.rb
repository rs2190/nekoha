class Public::CommentsController < ApplicationController

  # コメント登録処理
  def create

    # 投稿モデル取得
    @post = Post.find(params[:post_id])
    # データを受け取り新規登録するためのインスタンス作成
    comment = current_user.comments.new(comment_params)
    # コメント.ユーザーID = ログインしているユーザーID
    comment.user_id = current_user.id
    # コメント.投稿ID = 取得した投稿.id
    comment.post_id = @post.id
    # コメント登録
    comment.save

    # 遷移先
    redirect_to post_path(@post)

  end

  def update
  end

  def edit
  end

  def destroy
  end

  # ストロングパラメータ
  def comment_params
    params.require(:comment).permit(:comment_word)
  end

end
