require "test_helper"

class IntermediateControllerTest < ActionDispatch::IntegrationTest
  test "should get transition" do
    get intermediate_transition_url
    assert_response :success
  end
end
