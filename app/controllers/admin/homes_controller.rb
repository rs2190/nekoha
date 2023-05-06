class Admin::HomesController < ApplicationController

  before_action :authenticate_admin!

  # トップページ
  def top
  end
end
