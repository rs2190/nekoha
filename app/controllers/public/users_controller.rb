class Public::UsersController < ApplicationController

  before_action :authenticate_user!, only: [:edit ,:goodbye]

  # マイページ
  def show

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
