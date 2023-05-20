class Public::PostsController < ApplicationController

  # 投稿内容一覧（全て）
  def index

    @posts = Post.page(params[:page]).per(10).order(id: "DESC")

  end

  # 投稿内容一覧（全て）
  def user_index

    @posts = Post.where(user_id: current_user.id).page(params[:page]).per(10).order(id: "DESC")

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

  # 投稿内容詳細画面
  def show

    @post = post_find_params_id

  end

  # 投稿内容編集画面
  def edit

    @post = post_find_params_id

  end

  # 投稿内容更新
  def update

    @post = post_find_params_id

    if @post.update(post_params)

      notice("投稿内容を更新しました。")
      redirect_to post_path(@post.id)

    else

      render :edit

    end

  end

  # 投稿内容削除
  def destroy

    @post = post_find_params_id
    @post.destroy
    notice("投稿内容を削除しました。")
    redirect_to user_index_path

  end

  private

  # ストロングパラメータ
  def post_params

    params.require(:post).permit(:image, :title, :posts_comment, :tag_list)

  end


end
