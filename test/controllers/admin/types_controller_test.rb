require "test_helper"

class Admin::TypesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_types_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_types_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_types_create_url
    assert_response :success
  end

  test "should get show" do
    get admin_types_show_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_types_destroy_url
    assert_response :success
  end

  test "should get edit" do
    get admin_types_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_types_update_url
    assert_response :success
  end
end
