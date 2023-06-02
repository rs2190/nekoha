class Comment < ApplicationRecord

  # comment と user の 1 : N のアソシエーション実装
  belongs_to :user
  # comment と post の 1 : N のアソシエーション実装
  belongs_to :post

  # バリデーション
  with_options presence: true do

    validates :comment_word

  end

  # コメント日時
  def get_comment_date

    created_at.strftime('%Y/%m/%d %H:%M')

  end

    # コメント日時
  def get_comment_word

    if comment_word.length > 10

      # 最初の10文字取得
      word = comment_word.slice(0..10)
      word + "..."
    else

      comment_word

    end

  end

  # タイトル取得
  def get_post_title(post_id)

    Post.where(id: post_id).pluck(:title)[0]

  end

  # 投稿者ID取得
  def get_post_user_id(post_id)

    Post.where(id: post_id).pluck(:user_id)[0]

  end

  # 投稿ユーザー取得
  def get_post_user_name(post_id)

    post_user_id = get_post_user_id(post_id)

    User.where(id: post_user_id).pluck(:name)[0]

  end

end
