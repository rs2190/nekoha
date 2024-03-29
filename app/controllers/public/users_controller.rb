class Public::UsersController < ApplicationController

  # コントローラーに設定して、ログイン済ユーザーのみにアクセスを許可する
  before_action :authenticate_user!, only: [:edit ,:update, :unsubscribe, :goodbye ,:my_page]

  # マイページ
  def show
    # Userモデルを呼ぶ。
    @user = user_find_params_id

  end

  # マイページ
  def my_page
    # Userモデルを呼ぶ。
    @user = user_find

  end

  # プロフィール編集画面
  def edit

    @user = user_find

  end

  # プロフィール更新
  def update

    @user = user_find
    
    # バリデーションチェック
    if @user.update(user_params)

      notice("プロフィールを更新しました。")
      redirect_to my_page_path

    else

      render :edit

    end

  end

  # 退会確認画面
  def unsubscribe
  end

  # 退会処理
  def goodbye

    @user = user_find
    
    # 退会ステータスを有効
    @user.update(is_deleted: true)
    # ログアウト
    reset_session

    notice("退会完了いたしました。またのご利用お待ちしております。")
    redirect_to root_path

  end

  # 投稿内容一覧
  def posts

    userID = params[:user_id]
    @posts = Post.where(user_id: userID).page(params[:page]).per(10).order(id: "DESC")
    @user_name = get_name(userID)

  end

  # コメント一覧
  def comments

    userID = params[:user_id]
    @comments = Comment.where(user_id: userID).page(params[:page]).per(10).order(id: "DESC")
    @user_name = get_name(userID)

  end

  # いいね一覧
  def favorites

    userID = params[:user_id]
    @favorite = Favorite.where(user_id: userID).page(params[:page]).per(10).order(id: "DESC")
    @user_name = get_name(userID)

  end


  private

  # ストロングパラメータ
  def user_params

    # userタイプのモデル
    params.require(:user).permit(:name,:sex,:email,:self_introduction,:image)

  end

end
