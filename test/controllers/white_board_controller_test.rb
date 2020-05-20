require 'test_helper'

class WhiteBoardControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get white_board_main_url
    assert_response :success
  end

end
