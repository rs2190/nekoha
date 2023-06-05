class Public::HomesController < ApplicationController

  # トップページ
  def top

    @posts = Post.order(id: "DESC").limit(4)

  end

  # アバウトページ
  def about
  end
end
