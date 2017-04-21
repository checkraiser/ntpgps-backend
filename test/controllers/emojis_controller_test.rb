require 'test_helper'

class EmojisControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get emojis_index_url
    assert_response :success
  end

end
