class Admin::TypesController < ApplicationController

  # コントローラーに設定して、ログイン済管理者のみにアクセスを許可する
  before_action :authenticate_admin!

  # ねこずかん（種類一覧）
  def index

    # 種類モデルから1ページ分（データ30件）取得（降順）
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

      # 成功時処理
      # フラッシュメッセージ
      notice("ねこずかんを追加しました。")
      # 処理後遷移先
      redirect_to admin_type_path(@type.id)

    else

      # 失敗時処理
      # 処理後遷移先
      render :new
    end

  end

  # 種類詳細画面
  def show

    # 1件種類情報取得
    @type = type_find_params_id

  end

  # 種類情報の更新処理
  def edit

    # 1件種類情報取得
    @type = type_find_params_id

  end

  # 種類情報の更新処理
  def update

    # 1件種類情報取得
    @type = type_find_params_id

    # 更新時チェック(nバリデーションチェック)
    if @type.update(type_params)

      # 成功時処理
      # フラッシュメッセージ
      notice("ねこずかんを更新しました。")
      # 処理後遷移先
      redirect_to admin_type_path(@type.id)

    else

      # 失敗時処理
      # 処理後遷移先
      render :edit

    end

  end

  # 種類情報の更新処理
  def destroy

    # 1件種類情報取得
    type = type_find_params_id
    # 削除
    type.destroy
    # フラッシュメッセージ
    notice("ねこずかんから１件削除しました。")
    # 処理後遷移先
    redirect_to admin_types_path

  end

  private

  # ストロングパラメータ(Web上から受けつけたパラメータが、本当に安全なデータかどうかを検証した上で、取得するための仕組み)
  def type_params

    # typeモデルのカラム
    params.require(:type).permit(:image,:name,:body_length,:country,:tag_list,:detail)

  end
end
