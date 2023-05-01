# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ゲストログイン

# 管理者
User.create!(
             name: "ゲスト",
             email: "gest@xxxx.com",
             password:  "000000"
             )

# 管理者
Admin.create!(
             email: "admin@nekoha.com",
             password:  "000000"
             )