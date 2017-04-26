require 'test_helper'

class ReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get export" do
    get reports_export_url
    assert_response :success
  end

end
