require 'test_helper'

class WebGlobalControllerTest < ActionController::TestCase
  test "should get mainsite_navigator" do
    get :mainsite_navigator
    assert_response :success
  end

end
