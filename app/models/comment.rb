class Comment < ApplicationRecord

  # comment と user の 1 : N のアソシエーション実装
  belongs_to :user
  # comment と post の 1 : N のアソシエーション実装
  belongs_to :post

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

  # 名前取得
  def get_user_name(user_id)

    User.where(id: user_id).pluck(:name)[0]

  end

end
