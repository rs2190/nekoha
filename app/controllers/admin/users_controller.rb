class Admin::UsersController < ApplicationController

  before_action :authenticate_admin!

  def index

    @users = User.page(params[:page]).per(30).order(id: "DESC")

  end


  def show

    @user = user_find_params_id

  end

  # ユーザーステータス更新（有効）
  def welcome

    update_user_is_deleted(false)

  end

  # ユーザーステータス更新（退会）
  def goodbye

    update_user_is_deleted(true)

  end

  private

  # ストロングパラメータ
  def order_params

    params.require(:user).permit(:id)

  end


  # 削除フラグを更新して、一覧画面へ遷移する。（status: true(退会) or false（有効））
  def update_user_is_deleted(status)

    user = User.find(params[:user][:id])
    user.update(is_deleted: status)
    redirect_to admin_users_path

  end

end
