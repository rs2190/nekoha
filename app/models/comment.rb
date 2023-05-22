class Comment < ApplicationRecord

  # comment と user の 1 : N のアソシエーション実装
  belongs_to :user
  # comment と post の 1 : N のアソシエーション実装
  belongs_to :post

  # コメント日時
  def get_comment_date

    created_at.strftime('%Y/%m/%d %H:%M')

  end

end
