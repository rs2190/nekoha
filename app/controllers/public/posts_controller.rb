class Public::PostsController < ApplicationController

  def index

    @posts = Post.where(user_id: current_user.id).page(params[:page]).per(10).order(id: "ASC")

  end

  # 投稿内容登録画面
  def new

    # データを受け取り新規登録するためのインスタンス作成
    @post = Post.new

  end

  # 投稿内容登録処理
  def create

    # データを受け取り新規登録するためのインスタンス作成
    @post = Post.new(post_params)
    # Post.ユーザーID = ログインしたログインした顧客のid
    @post.user_id = current_user.id

    # 登録時チェック
    if @post.save
      # 成功時
      notice("投稿完了しました。")
      redirect_to post_path(@post.id)
    else

      render :new
    end

  end

  def edit

     @posts = Post.find(user_id: current_user.id)

  end

  def update
  end

  def destroy
  end

  private

  # ストロングパラメータ
  def post_params

    params.require(:post).permit(:image,:title,:posts_comment)

  end


end
