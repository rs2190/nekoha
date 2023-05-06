class Public::UsersController < ApplicationController

  before_action :authenticate_user!, only: [:edit ,:update, :unsubscribe, :goodbye]

  # マイページ
  def show
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
    @user.update(is_deleted: true)
    # ログアウト
    reset_session

    notice("退会完了いたしました。またのご利用お待ちしております。")
    redirect_to root_path

  end

  private

  # ストロングパラメータ
  def user_params

    params.require(:user).permit(:name,:sex,:email,:self_introduction,:image)

  end

end
