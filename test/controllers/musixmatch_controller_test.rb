require "test_helper"

class MusixmatchControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get musixmatch_show_url
    assert_response :success
  end
end
