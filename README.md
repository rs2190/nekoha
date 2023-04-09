# nekoha（ネコハ）

## サイト概要
### サイトテーマ
猫好き、猫派のユーザーが写真などを投稿でき、世界中の猫の種類を紹介するコミュニティサイト。

### テーマを選んだ理由
自分がライトな猫派のため、猫の写真や画像が見れるのがあれば良いなと考え
またあまり猫の種類に詳しくない為、世界中の猫が知れる図鑑のような一覧機能があれば便利だと考えこのテーマにしました、

### ターゲットユーザ
猫好き、猫派のユーザー

### 主な利用シーン
飼っている猫などの写真を投稿するとき、世界中の猫の種類を知りたい時。

## 設計書
後で記載

## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9

## 使用素材
- ActiveStorage
- devise
- kaminari
- bootstrap【yarn add jquery bootstrap@4.5 popper.js】
- fontawesome【yarn add @fortawesome/fontawesome-free@5.15.4】

## インストール(git clone後の処理 ※現段階)
- $ git clone git@github.com:rs2190/nekoha.git
- $ cd nekoha
- $ bundle install
- $ yarn install
- $ rails webpacker:install
- $ rails webpacker:compile
- $ rails db:migrate (rake db:migrate:reset)
- $ rails db:seed

## 実装者
- 鈴木 龍