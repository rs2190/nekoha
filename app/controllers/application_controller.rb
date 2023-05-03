class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  # サインアウト後の遷移
  def after_sign_out_path_for(resource)

     # 登録したモデル
    case resource

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

  # フラッシュメッセージを定義(正常)
  def notice(word)

    flash[:notice] = word

  end

end

