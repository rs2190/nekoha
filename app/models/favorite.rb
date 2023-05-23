class Favorite < ApplicationRecord

  # favorite と users の 1 : N のアソシエーション実装
  belongs_to :user
  # favorite と posts の 1 : N のアソシエーション実装
  belongs_to :post

  # タイトル取得
  def get_post_title(post_id)

    Post.where(id: post_id).pluck(:title)[0]

  end

  # 名前取得
  def get_user_name(user_id)

    User.where(id: user_id).pluck(:name)[0]

  end

end
