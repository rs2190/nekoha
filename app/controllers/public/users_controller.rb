class Public::UsersController < ApplicationController

  before_action :authenticate_user!, only: [:edit ,:update, :unsubscribe, :goodbye]

  # マイページ
  def show
    # Userモデルを呼ぶ。
    @user = user_find

  end

  def edit
  end

  def update
  end

  def unsubscribe
  end

  def goodbye
  end
end
