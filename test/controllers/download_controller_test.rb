require "test_helper"

class DownloadControllerTest < ActionDispatch::IntegrationTest
  test "show success" do
    get download_url(file_infos(:hello))
    assert_response :ok
  end

  test "show failure" do
    assert_raise ActiveRecord::RecordNotFound do
      get download_url("404")
    end
  end
end
