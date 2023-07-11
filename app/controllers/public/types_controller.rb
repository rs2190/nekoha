class Public::TypesController < ApplicationController

  # ねこずかん（種類一覧）
  def index

    # 投稿モデルから1ページ分（データ10件）取得（降順）
    @types = Type.page(params[:page]).per(10).order(id: "DESC")

    # タグ検索
    if params[:tag_name]

      # タグ検索を行い、投稿モデルから1ページ分（データ10件）取得（降順）
      @types = Type.tagged_with("#{params[:tag_name]}").page(params[:page]).per(10).order(id: "DESC")

    # キーワード検索
    elsif params[:word]

      # params[:word] を サニタイズ(改行などの特別な意味を持つ文字の特別さを無効化する処理)する。
      key_word =  "%#{ActiveRecord::Base.sanitize_sql_like(params[:word].to_s)}%"

      # サニタイズしたキーワードで、種類モデルの全項目を部分一致で検索を行う。
      # 種類モデルから1ページ分（データ10件）取得（降順）
      @types = Type.where("name like ? or body_length like ? or country like ? or detail like ?", key_word, key_word, key_word, key_word).page(params[:page]).per(10).order(id: "DESC")

    end

  end

  # 種類詳細画面
  def show

    # 1件種類情報取得
    @type = type_find_params_id

  end
end
