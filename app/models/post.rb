class Post < ApplicationRecord

  # 1 : N　の関連付け（アソシエーション: association）
  # posts と users の 1 : N のアソシエーション実装
  belongs_to :user

   # favorites と posts の 1 : N のアソシエーション実装
  has_many :favorites, dependent: :destroy
  # comments と posts の 1 : N のアソシエーション実装
  has_many :comments, dependent: :destroy

  # ActiveStorage(imageカラム)を追加して、画像を投稿出来るようにする。
  has_one_attached :image
  # acts_as_taggable_on(tagsカラム)を追加して、タグリストを登録出来るようにする。
  acts_as_taggable_on :tags

  # バリデーション
  with_options presence: true do

    validates :title
    validates :posts_comment

  end

  def get_post_image_wide_height(width, height)

    # 画像を取得出来るか
    upload_default_image unless image.attached?
     # 画像サイズの変更(px)
    image.variant(resize_to_limit: [width, height]).processed
  end

  # プロフィール画像を取得する。
  def get_show_post_image(size)

    # 画像を取得出来るか
    upload_default_image unless image.attached?
    # 画像サイズの変更(px)
    image.variant(resize: size).processed
  end

  # 投稿画像を取得する。
  def get_image

    # 画像を取得出来るか
    upload_default_image unless image.attached?
    # 画像サイズの変更(px)
    image.variant( resize: "100x100^" ).processed
  end

  # 投稿画像が存在しない場合、画像が取得する。
  def upload_default_image
    # 画像を取得して、
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end

  # 投稿日時
  def get_posted_date

    created_at.strftime('%Y/%m/%d %H:%M')

  end

  # いいね判定
  def favorited?(user)

    favorites.where(user_id: user.id).exists?

  end

end
