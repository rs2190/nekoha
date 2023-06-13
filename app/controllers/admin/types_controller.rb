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
    @type = Type.new(type_params)
    # 登録時チェック
    if @type.save
      # 成功時
      notice("ねこずかんを追加しました。")
      redirect_to admin_type_path(@type.id)
    else

      render :new
    end

  end

  # 種類詳細画面
  def show

    @type = type_find_params_id

  end

  # 種類情報の更新処理
  def edit

    @type = type_find_params_id

  end

  # 種類情報の更新処理
  def update

    @type = type_find_params_id

    if @type.update(type_params)

      notice("ねこずかんを更新しました。")
      redirect_to admin_type_path(@type.id)

    else

      render :edit

    end

  end

  # 種類情報の更新処理
  def destroy

    type = type_find_params_id
    type.destroy
    notice("ねこずかんから１件削除しました。")
    redirect_to admin_types_path

  end

  private

  # ストロングパラメータ
  def type_params

    params.require(:type).permit(:image,:name,:body_length,:country,:tag_list,:detail)

  end
end
