class Public::FavoritesController < ApplicationController

  # いいね登録処理
  def create

    # postモデルからリクエストパラメータで送られてきた投稿idを検索条件に取得する
    @post = Post.find(params[:post_id])

    # いいねモデルを作成
    # いいね．ユーザーID = ログインしているユーザーID
    # いいね．投稿ID = リクエストパラメータで送られてきた投稿id
    favorite = current_user.favorites.new(user_id: current_user.id, post_id: params[:post_id])

    # 登録
    favorite.save
    # 処理後遷移先
    redirect_to post_path(params[:post_id])

  end

   # いいね削除録処理
  def destroy
    # postモデルからリクエストパラメータで送られてきた投稿idを検索条件に取得する
    @post = Post.find(params[:post_id])

    # いいねモデルを作成
    # いいね．ユーザーID = ログインしているユーザーID
    # いいね．投稿ID = リクエストパラメータで送られてきた投稿id
    favorite = current_user.favorites.find_by(user_id: current_user.id, post_id: params[:post_id])

    # 削除
    favorite.destroy
    # 処理後遷移先
    redirect_to post_path(@post.id)
  end

end
