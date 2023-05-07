class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      # 会員ID
      t.integer :user_id,  null: false
      # タイトル名
      t.string :title,  null: false
      # 投稿コメント
      t.text :posts_comment,  null: false

      t.timestamps

    end
  end
end
