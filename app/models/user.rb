class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 性別のenum
  enum sex: { another: 0, male: 1, famale: 2 }

  def self.guest
    find_or_create_by!(email: 'aaa@aaa.com') do |user|

      #　パスワードをランダム生成
      user.password = SecureRandom.urlsafe_base64
      user.password_confirmation = user.password
      user.name = 'ゲスト'
      user.sex = 0
      user.self_introduction = "ゲストログイン用です。"
      user.is_deleted = false

    end

  end

end
