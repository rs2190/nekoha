class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|

       # ユーザーID
      t.integer :user_id,  null: false
      # 投稿ID
      t.integer :post_id,  null: false

      t.timestamps
    end
  end
end
