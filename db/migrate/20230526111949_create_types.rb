class CreateTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :types do |t|

      # 種類名
      t.string :name,  null: false
      # 体長
      t.string :body_length,  null: false
      # 原産国
      t.string :country,  null: false
      # 詳細
      t.text :detail,  null: false

      t.timestamps
    end
  end
end
