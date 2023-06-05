class Public::FavoritesController < ApplicationController

  # いいね登録処理
  def create

    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(user_id: current_user.id, post_id: params[:post_id])
    favorite.save
    redirect_to post_path(params[:post_id])

  end

   # いいね削除録処理
  def destroy

    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(user_id: current_user.id, post_id: params[:post_id])
    favorite.destroy
    redirect_to post_path(@post.id)
  end

end
