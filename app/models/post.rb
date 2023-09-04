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

  # バリデーション(入力必須のバリデーションをまとめる。)
  with_options presence: true do

    # タイトル
    validates :title
    # 投稿コメント
    validates :posts_comment

  end

  # 画面の画像ファイル表示用メソッド（第1引数：幅　第2引数:高さ）
  def get_post_image_wide_height(width, height)

    # 画像を取得出来るか
    upload_default_image unless image.attached?
     # 画像サイズの変更(px)
    image.variant(resize_to_limit: [width, height]).processed
  end

  # プロフィール画像を取得する。（第1引数：サイズ）
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
    # ディレクトリから画像を取得する。
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end

  # 投稿日時
  def get_posted_date

    # 日時フォーマットを修正
    created_at.strftime('%Y/%m/%d %H:%M')

  end

  # いいね判定
  def favorited?(user)

    # ユーザーIDで検索して、いいねテーブルにあるかチェックする。
    favorites.where(user_id: user.id).exists?

  end

end
