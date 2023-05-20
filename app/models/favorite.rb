class Favorite < ApplicationRecord

  # favorite と users の 1 : N のアソシエーション実装
  belongs_to :user
  # favorite と posts の 1 : N のアソシエーション実装
  belongs_to :post



end
