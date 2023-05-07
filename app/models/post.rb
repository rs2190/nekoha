class Post < ApplicationRecord

  # 1 : N　の関連付け（アソシエーション: association）
  # posts と users の 1 : N のアソシエーション実装
  belongs_to :user
  # ActiveStorage(imageカラム)を追加して、画像を投稿出来るようにする。
  has_one_attached :image

    # プロフィール画像を取得する。
  def get_profile_image(size)

    # 画像を取得出来るか
    upload_default_image unless image.attached?
    # 画像サイズの変更(px)
    image.variant(resize: size)
  end

  # プロフィール画像が存在しない場合、画像が取得する。
  def upload_default_image
    # 画像を取得して、
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end


end
