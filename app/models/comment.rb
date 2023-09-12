class Comment < ApplicationRecord

  # comment と user の 1 : N のアソシエーション実装
  belongs_to :user
  # comment と post の 1 : N のアソシエーション実装
  belongs_to :post

  # バリデーション(入力必須のバリデーションをまとめる。)
  with_options presence: true do

    # コメント内容
    validates :comment_word

  end

  # コメント日時
  def get_comment_date

    # 日時フォーマットを修正
    created_at.strftime('%Y/%m/%d %H:%M')

  end

  # コメント省略
  def get_comment_word

    # 10文字以上の場合
    if comment_word.length > 10

      # 最初の10文字取得
      word = comment_word.slice(0..10)
      # コメントを省略して出力する。（最初の10文字 + "..."）
      word + "..."

    else

      comment_word

    end

  end

  # タイトル取得（第一引数：投稿ID）
  def get_post_title(post_id)

    # 投稿IDで検索して、0番目のタイトルを取得する。
    Post.where(id: post_id).pluck(:title)[0]

  end

  # 投稿者ID取得（第一引数：投稿ID）
  def get_post_user_id(post_id)

    # 投稿IDで検索して、0番目のユーザーIDを取得する。
    Post.where(id: post_id).pluck(:user_id)[0]

  end

  # 投稿ユーザーの取得
  def get_post_user_name(post_id)

    # 投稿モデルのユーザーIDを取得。
    post_user_id = get_post_user_id(post_id)
    # 取得したユーザーIDで、ユーザーネームを取得。
    User.where(id: post_user_id).pluck(:name)[0]

  end

end
