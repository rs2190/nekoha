class Public::TypesController < ApplicationController

  # ねこずかん（種類一覧）
  def index

    @types = Type.page(params[:page]).per(10).order(id: "DESC")

    # タグ検索
    if params[:tag_name]

      @types = Type.tagged_with("#{params[:tag_name]}").page(params[:page]).per(10).order(id: "DESC")

    # キーワード検索
    elsif params[:word]

      @types = Type.where(['name LIKE(?) OR body_length LIKE(?) OR country LIKE(?) OR detail LIKE(?) ', "%#{params[:word]}%", "%#{params[:word]}%",  "%#{params[:word]}%", "%#{params[:word]}%"]).page(params[:page]).per(10).order(id: "DESC")

    end

  end

  # 種類詳細画面
  def show

    @type = type_find_params_id

  end
end
