class Public::FavoritesController < ApplicationController

  def create

    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(user_id: current_user.id, post_id: params[:post_id])
    favorite.save
    redirect_to post_path(params[:post_id])

  end

  def destroy

    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(user_id: current_user.id, post_id: params[:post_id])
    favorite.destroy
    redirect_to post_path(@post.id)
  end

end
