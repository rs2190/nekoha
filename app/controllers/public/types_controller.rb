class Public::TypesController < ApplicationController

  # ねこずかん（種類一覧）
  def index

    @types = Type.page(params[:page]).per(10).order(id: "DESC")

    # タグ検索
    if params[:tag_name]

      @types = Type.tagged_with("#{params[:tag_name]}").page(params[:page]).per(10).order(id: "DESC")

    # キーワード検索
    elsif params[:word]

      # params[:word] を サニタイズする。
      key_word =  "%#{ActiveRecord::Base.sanitize_sql_like(params[:word].to_s)}%"

      # Typeモデルのカラムに、キーワード部分一致するものを取得する。
      @types = Type.where("name like ? or body_length like ? or country like ? or detail like ?", key_word, key_word, key_word, key_word).page(params[:page]).per(10).order(id: "DESC")

    end

  end

  # 種類詳細画面
  def show

    @type = type_find_params_id

  end
end
