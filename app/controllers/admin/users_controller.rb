class Admin::UsersController < ApplicationController

  # コントローラーに設定して、ログイン済管理者のみにアクセスを許可する
  before_action :authenticate_admin!

  # ユーザー一覧
  def index

    # ユーザーモデルから1ページ分（データ30件）取得（降順）
    @users = User.page(params[:page]).per(30).order(id: "DESC")

  end

  # ユーザー詳細
  def show

    # 1件ユーザー情報取得
    @user = user_find_params_id

  end

  # ユーザー編集画面
  def edit

    # 1件ユーザー情報取得
    @user = user_find_params_id

  end

  # ユーザー情報更新
  def update

    # 1件ユーザー情報取得
    @user = user_find_params_id

    # 更新時チェック
    if @user.update(user_params)

      # 成功時処理
      # フラッシュメッセージ
      notice("対象のユーザー情報を更新しました。")
      # 処理後遷移先
      redirect_to admin_user_path(@user.id)

    else

      # 失敗時処理
      # 処理後遷移先
      render :edit

    end

  end

  private

  # ストロングパラメータ
  def user_params

    # userタイプのモデル
    params.require(:user).permit(:name,:sex,:email,:self_introduction,:is_deleted)

  end

end
