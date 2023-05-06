require "test_helper"

class Admin::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_users_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_users_show_url
    assert_response :success
  end

  test "should get welcome" do
    get admin_users_welcome_url
    assert_response :success
  end

  test "should get goodbye" do
    get admin_users_goodbye_url
    assert_response :success
  end
end
