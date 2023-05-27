class Public::TypesController < ApplicationController

  # ねこずかん（種類一覧）
  def index

    @types = Type.page(params[:page]).per(10).order(id: "DESC")

  end

  # 種類詳細画面
  def show

    @type = type_find_params_id

  end
end
