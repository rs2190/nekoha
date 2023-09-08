class Type < ApplicationRecord

  # ActiveStorage(imageカラム)を追加して、画像を投稿出来るようにする。
  has_one_attached :image
  # acts_as_taggable_on(tagsカラム)を追加して、タグリストを登録出来るようにする。
  acts_as_taggable_on :tags

  # バリデーション(入力必須のバリデーションをまとめる。)
  with_options presence: true do

    # 種類名
    validates :name
    # 体長
    validates :body_length
    # 原産国
    validates :country
    # 詳細
    validates :detail

  end

  # 投稿画像を取得する。（第1引数：サイズ）
  def get_image(size)

    # 画像を取得出来るか
    upload_default_image unless image.attached?
    # 画像サイズの変更(px)
    image.variant(resize: size).processed
  end

  # 投稿画像が存在しない場合、イメージなしの画像を取得する。
  def upload_default_image
    # 画像なしの場合のjpeg画像を取得する。
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end

  # 投稿日時
  def get_posted_date

    # 日時フォーマットを修正
    created_at.strftime('%Y/%m/%d %H:%M')

  end


end
