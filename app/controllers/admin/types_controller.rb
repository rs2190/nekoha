class Admin::TypesController < ApplicationController

  before_action :authenticate_admin!

  # ねこずかん（種類一覧）
  def index

    @types = Type.page(params[:page]).per(30).order(id: "DESC")

  end

  # 種類登録画面
  def new

    # データを受け取り新規登録するためのインスタンス作成
    @type = Type.new

  end

  # 種類情報の新規登録処理
  def create

    # データを受け取り新規登録するためのインスタンス作成
    type = Type.new(type_params)

    # コメント登録
    type.save

    # 遷移先
    redirect_to admin_type_path(type.id)

  end

  # 種類詳細画面
  def show

    @type = type_find_params_id

  end

  def edit

     @type = type_find_params_id

  end

  def update
  end

  def destroy
  end

  private

  # ストロングパラメータ
  def type_params

    params.require(:type).permit(:image,:name,:body_length,:from,:tag_list,:detail)

  end
end
