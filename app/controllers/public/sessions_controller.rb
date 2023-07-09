# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :user_state, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  # サインインの処理
  def after_sign_in_path_for(resource)

    notice("ログイン完了しました。")

    #ログイン後の遷移先
    root_path

  end

  # ゲストユーザーのログイン
  def guest_sign_in

    #userモデルのguestメソッドを呼ぶ
    user = User.guest
    # ゲストユーザーをログインさせる
    sign_in user
    # フラッシュメッセージ
    notice("ゲストユーザーとしてログインしました。")
    # 処理後遷移先
    redirect_to root_path

  end

  protected

   # 退会しているかを判断するメソッド
  def user_state
    # 入力されたemailからアカウントを1件取得
    @user = User.find_by(email: params[:user][:email])
    ##アカウントを取得できなかった場合、このメソッドを終了する
    return if !@user

    # 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
    if @user.valid_password?(params[:user][:password]) && @user.is_deleted

      # trueだった場合、退会しているのでサインアップ画面に遷移する

      # フラッシュメッセージ
      alert("入力したメールアドレスは、退会しているため新規登録をお願いいたします。")
      # 処理後遷移先
      redirect_to new_user_registration_path

    end

  end

end
