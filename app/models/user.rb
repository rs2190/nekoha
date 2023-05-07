class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 1 : N　の関連付け（アソシエーション: association）
  # posts と users の 1 : N のアソシエーション実装
  has_many :posts, dependent: :destroy
  # ActiveStorage(imageカラム)を追加して、画像を投稿出来るようにする。
  has_one_attached :image

  # 性別のenum
  enum sex: { another: 0, male: 1, famale: 2 }

  # ゲストログイン時のデータを作成
  def self.guest
    find_or_create_by!(email: 'guest@nekoha.com') do |user|

      #　パスワードをランダム生成
      user.password = SecureRandom.urlsafe_base64
      user.password_confirmation = user.password
      user.name = 'ゲスト'
      user.sex = 0
      user.self_introduction = "ゲストログイン用です。"
      user.is_deleted = false

    end

  end

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
