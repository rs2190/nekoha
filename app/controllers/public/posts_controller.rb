class Public::PostsController < ApplicationController

  # コントローラーに設定して、ログイン済ユーザーのみにアクセスを許可する。（new、create、update、edit、destroy）
  before_action :authenticate_user!, only: [:new , :create, :update, :edit ,:destroy]

  # 投稿内容一覧（全て）
  def index

    # 投稿モデルから1ページ分（データ10件）取得（降順）
    @posts = Post.page(params[:page]).per(10).order(id: "DESC")

    # タグ検索
    if params[:tag_name]

      # タグ検索を行い、投稿モデルから1ページ分（データ10件）取得（降順）
      @posts = Post.tagged_with("#{params[:tag_name]}").page(params[:page]).per(10).order(id: "DESC")

    # キーワード検索

    # 「投稿内容で検索」タグで検索した場合
    elsif params["model"]  == 'post'

      # params[:word] を サニタイズ(改行などの特別な意味を持つ文字の特別さを無効化する処理)する。
      key_word =  "%#{ActiveRecord::Base.sanitize_sql_like(params[:word].to_s)}%"

      # サニタイズしたキーワードで、投稿モデルのカラム（タイトル名、投稿コメント）を部分一致で検索を行う。
      # 投稿モデルから1ページ分（データ10件）取得（降順）
      @posts = Post.where("title like ? or posts_comment like ? ", key_word, key_word).page(params[:page]).per(10).order(id: "DESC")

    # 「投稿ユーザーで検索」タグで検索した場合
    elsif params["model"]  == 'user'

      # params[:word] を サニタイズ(改行などの特別な意味を持つ文字の特別さを無効化する処理)する。
      key_word =  "%#{ActiveRecord::Base.sanitize_sql_like(params[:word].to_s)}%"
      # サニタイズしたキーワードで、ユーザーモデルのカラム（ユーザー名）を部分一致で検索を行う。
      # 投稿モデルから1ページ分（データ10件）取得（降順）
      @posts =  Post.joins(:user).where("users.name like ?", key_word).page(params[:page]).per(10).order(id: "DESC")

    end

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

      # 成功時処理
      # フラッシュメッセージ
      notice("投稿完了しました。")
      # 処理後遷移先
      redirect_to post_path(@post.id)
    else

      # 失敗時処理
      # 処理後遷移先
      render :new

    end

  end

  # 投稿内容詳細画面
  def show

    # 1件投稿情報取得
    @post = post_find_params_id
    # データを受け取り新規登録するためのインスタンス作成
    @comment = Comment.new

  end

  # 投稿内容編集画面
  def edit

     # 1件投稿情報取得
    @post = post_find_params_id

  end

  # 投稿内容更新
  def update

    # 1件投稿情報取得
    @post = post_find_params_id

    # 更新時チェック
    if @post.update(post_params)

      # 成功時処理
      # フラッシュメッセージ
      notice("投稿内容を更新しました。")
       # 処理後遷移先
      redirect_to post_path(@post.id)

    else

      # 失敗時処理
      # 処理後遷移先
      render :edit

    end

  end

  # 投稿内容削除
  def destroy

    # 1件投稿情報取得
    @post = post_find_params_id
    # 削除
    @post.destroy
    # フラッシュメッセージ
    notice("投稿内容を削除しました。")
    # 処理後遷移先
    redirect_to user_posts_path(current_user.id)

  end

  private

  # ストロングパラメータ
  def post_params

    params.require(:post).permit(:image, :title, :posts_comment, :tag_list)

  end


end
