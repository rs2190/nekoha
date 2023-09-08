class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 1 : N　の関連付け（アソシエーション: association）
  # posts と users の 1 : N のアソシエーション実装
  has_many :posts, dependent: :destroy
  # favorites と users の 1 : N のアソシエーション実装
  has_many :favorites, dependent: :destroy
  # comments と users の 1 : N のアソシエーション実装
  has_many :comments, dependent: :destroy

  # バリデーション(入力必須のバリデーションをまとめる。)
  with_options presence: true do

    # ユーザー名
    validates :name
    # 性別
    validates :sex
    # メールアドレス
    validates :email
    # 自己紹介文
    validates :self_introduction

  end

  # ActiveStorage(imageカラム)を追加して、画像を投稿出来るようにする。
  has_one_attached :image

  # 性別のenum（0：その他、1：男、2：）
  enum sex: { another: 0, male: 1, famale: 2 }

  # ゲストログイン時のデータを作成
  def self.guest

    # ユーザーモデルで、ゲストログイン用のメールアドレスが、1件あるか確認する。
    find_or_create_by!(email: 'guest@nekoha.com') do |user|

      #　パスワードをランダム生成
      user.password = SecureRandom.urlsafe_base64
      #　確認用パスワード
      user.password_confirmation = user.password
      #　ユーザーネーム
      user.name = 'ゲスト'
      #　性別
      user.sex = 0
      #　自己紹介文
      user.self_introduction = "ゲストログイン用です。"
      # 退会ステータス
      user.is_deleted = false

    end

  end

  # プロフィール画像を取得する。（第1引数：サイズ）
  def get_profile_image(size)

    # 画像を取得出来るか
    upload_default_image unless image.attached?
    # 画像サイズの変更(px)
    image.variant(resize: size).processed

  end

  # プロフィール画像が存在しない場合、イメージなしの画像を取得する。
  def upload_default_image

    # 画像なしの場合のjpeg画像を取得する。
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')

  end

end
