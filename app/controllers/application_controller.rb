class ApplicationController < ActionController::Base

  # devise利用の機能（ユーザ登録、ログイン認証など）が使われる前に、configure_permitted_parametersメソッドが実行
  before_action :configure_permitted_parameters, if: :devise_controller?

  # サインアウト後の遷移
  def after_sign_out_path_for(resource)

    # 登録したモデル
    case resource
    # Admins(管理者)
    when :admin then
      new_admin_session_path
    # Users(ユーザー)
    when :user then
      root_path
    end

  end

  # protected メソッド
  protected

  # deviseのストロングパラメータ。
  def configure_permitted_parameters

    devise_parameter_sanitizer.permit(
      # サインアップ
      :sign_up,
        keys: [
          :name,
          :email,
          :self_introduction,
          :encrypted_password
        ]
    )

  end

  # public メソッド
  public

  # userモデルからログインしたユーザーのid（current_user）を検索条件に取得する。
  def user_find

    # ログインしたユーザーのid（current_user）で検索。
    User.find(current_user.id)

  end

  # userモデルからリクエストパラメータで送られてきたユーザーidを検索条件に取得する。
  def user_find_params_id

    # リクエストパラメータで送られてきたユーザーidで検索。
    User.find(params[:id])

  end

  # postモデルからリクエストパラメータで送られてきた投稿idを検索条件に取得する。
  def post_find_params_id

    # リクエストパラメータで送られてきた投稿idで検索。
    Post.find(params[:id])

  end

  # commentモデルからリクエストパラメータで送られてきたコメントidを検索条件に取得する。
  def comment_find_params_id

    # リクエストパラメータで送られてきたコメントidで検索。
    Comment.find(params[:id])

  end

  # typeモデルからリクエストパラメータで送られてきた種類idを検索条件に取得する。
  def type_find_params_id

    # リクエストパラメータで送られてきた種類idで検索。
    Type.find(params[:id])

  end

  # フラッシュメッセージを定義(正常)
  def notice(msg)

    flash[:notice] = msg

  end

  # フラッシュメッセージを定義(異常)
  def alert(msg)

    flash[:alert] = msg

  end

  # userモデルから、ユーザーIDをパラメータに名前を取得する。
  def get_name(user_id)

    #ユーザーIDをパラメータに名前を取得する。
    User.where(id: user_id).pluck(:name)[0]

  end

end

