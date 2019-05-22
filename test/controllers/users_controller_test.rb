require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get my_profil" do
    get users_my_profil_url
    assert_response :success
  end

end
