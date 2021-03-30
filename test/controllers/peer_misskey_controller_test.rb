require "test_helper"

class PeerMisskeyControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get peer_misskey_create_url
    assert_response :success
  end
end
