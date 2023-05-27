require "test_helper"

class Public::TypesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_types_index_url
    assert_response :success
  end

  test "should get show" do
    get public_types_show_url
    assert_response :success
  end
end
