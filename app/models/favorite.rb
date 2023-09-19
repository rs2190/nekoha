class Favorite < ApplicationRecord

  # favorite と users の 1 : N のアソシエーション実装
  belongs_to :user
  # favorite と posts の 1 : N のアソシエーション実装
  belongs_to :post

  # タイトル取得（第一引数：投稿ID）
  def get_post_title(post_id)

    # 投稿IDで検索して、0番目のタイトルを取得する。
    Post.where(id: post_id).pluck(:title)[0]

  end

  # 投稿者ID取得（第一引数：投稿ID）
  def get_post_user_id(post_id)

    # 投稿IDで検索して、0番目の投稿者IDを取得する。
    Post.where(id: post_id).pluck(:user_id)[0]

  end

  # 投稿ユーザー取得（第一引数：投稿ID）
  def get_post_user_name(post_id)

    # 投稿モデルのユーザーIDを取得。
    post_user_id = get_post_user_id(post_id)
    # 取得したユーザーIDで、ユーザーネームを取得。
    User.where(id: post_user_id).pluck(:name)[0]

  end

end
