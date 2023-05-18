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

  # userモデルを、ログインしたユーザーのid（current_user）を検索条件に取得する。
  def user_find

    User.find(current_user.id)

  end

  # userモデルを、リクエストパラメータで送られてきたユーザーidを検索条件に取得する。
  def user_find_params_id

    User.find(params[:id])

  end

  # postモデルを、リクエストパラメータで送られてきた投稿idを検索条件に取得する。
  def post_find_params_id

   Post.find(params[:id])

  end

  # フラッシュメッセージを定義(正常)
  def notice(msg)

    flash[:notice] = msg

  end

    # フラッシュメッセージを定義(異常)
  def alert(msg)

    flash[:alert] = msg

  end

end

