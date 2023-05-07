class Admin::UsersController < ApplicationController

  before_action :authenticate_admin!

  def index

    @users = User.page(params[:page]).per(30).order(id: "DESC")

  end

  # ユーザー詳細
  def show

    @user = user_find_params_id

  end

  # ユーザー編集画面
  def edit

    @user = user_find_params_id

  end

  # ユーザー情報更新
  def update

    @user = user_find_params_id

    if @user.update(user_params)

      notice("対象のユーザー情報を更新しました。")
      redirect_to admin_user_path(@user.id)

    else

      render :edit

    end


  end

  private

  # ストロングパラメータ
  def user_params

    params.require(:user).permit(:name,:sex,:email,:self_introduction,:is_deleted)

  end

end
