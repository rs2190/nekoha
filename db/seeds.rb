# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



# 管理者
Admin.destroy_all
Admin.create!(
             email: "admin@nekoha.com",
             password:  "000000"
             )

User.destroy_all
# ユーザー
50.times  do |n|

  User.create!(
      email: "user#{n + 1}@nekoha.com",
      name: "ユーザー#{n + 1}",
      password: "000000",
      self_introduction: "ユーザー#{n + 1}です。お願いします。"
    )

end

Post.destroy_all

# 投稿
50.times  do |n|

posts =
  Post.create!(
      user_id: n + 1,
      title: "うちの猫です。No.#{n + 1}",
      posts_comment: "かわいいです。No.#{n + 1}"
    )

    # タグ
    if n > 30

        posts.tag_list.add("かわいい", "ペット", "No.#{n + 1}")

    elsif n > 15

        posts.tag_list.add("キュート", "No.#{n + 1}")

    else
        posts.tag_list.add("すてき", "No.#{n + 1}")
    end

    # 画像
    posts.image.attach(io: File.open(Rails.root.join("app/assets/images/cats/cat#{n + 1}.jpg")), filename: "cat#{n + 1}.jpg")
    posts.save
end

# コメント、いいね
50.times  do |n|

    if n == 49
        Comment.create!(
            user_id: n + 1,
            post_id: 1,
            comment_word: "ユーザー#{n + 1}です。かわいい猫の写真ですね！",
        )

        Favorite.create!(
            user_id: n + 1,
            post_id: 1
        )
    elsif n == 50

        Comment.create!(
            user_id: n,
            post_id: 1,
            comment_word: "ユーザー#{n}です。かわいい猫の写真ですね！",
        )

        Favorite.create!(
            user_id: n,
            post_id: 1
        )

    else
        Comment.create!(
            user_id: n + 1,
            post_id: n + 2,
            comment_word: "ユーザー#{n + 1}です。かわいい猫の写真ですね！",
        )

        Favorite.create!(
            user_id: n + 1,
            post_id: n + 2
        )
    end

end

Type.destroy_all

mikeneko =
Type.create!(
    name: "三毛猫",
    body_length: "26~28cm",
    country: "日本",
    detail: "かわいい",
    )
mikeneko.tag_list.add("かわいい", "キュート")
mikeneko.save

kuroneko =
Type.create!(
    name: "黒猫",
    body_length: "約25cm",
    country: "日本",
    detail: "かわいい"
    )
kuroneko.tag_list.add("かわいい", "黒猫", "キュート")
kuroneko.save


amesho =
Type.create!(
    name: "アメリカンショートヘアー",
    body_length: "約40～60cm",
    country: "アメリカ",
    detail: "かわいい"
    )
amesho.tag_list.add("アメショ", "キュート")
amesho.save