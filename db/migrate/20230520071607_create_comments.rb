class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|

      # ユーザーID
      t.integer :user_id,  null: false
      # 投稿ID
      t.integer :post_id,  null: false
      # コメント内容
      t.string :comment,  null: false

      t.timestamps
    end
  end
end
