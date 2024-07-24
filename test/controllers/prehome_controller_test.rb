require "test_helper"

class PrehomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get prehome_index_url
    assert_response :success
  end
end
