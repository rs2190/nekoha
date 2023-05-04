class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  # サインアウト後の遷移
  def after_sign_out_path_for(resource)

     # 登録したモデル
    case resource
    when :admin then
      root_path
    # Users(ユーザー)
    when :user then
      root_path
    end

  end

  protected

  # deviseのストロングパラメータ。
  def configure_permitted_parameters

    devise_parameter_sanitizer.permit(
      # サインアップ
      :sign_up,
        keys: [
          :name,
          :email,
          :encrypted_password,
        ]
    )

  end

  public

  # userモデルを、ログインした顧客のid（current_customer）で取得する。
  def user_find

    User.find(current_user.id)

  end

  # フラッシュメッセージを定義(正常)
  def notice(messeage)

    flash[:notice] = messeage

  end

end

