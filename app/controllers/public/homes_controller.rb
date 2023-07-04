class Public::HomesController < ApplicationController

  # トップページ
  def top

    # 投稿モデルから1ページ分（データ4件）取得（降順）
    @posts = Post.order(id: "DESC").limit(4)

  end

  # アバウトページ
  def about
  end
end
