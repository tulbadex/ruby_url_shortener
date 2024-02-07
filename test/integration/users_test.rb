require "test_helper"

class UsersTest < ActionDispatch::IntegrationTest

    test "Guest user" do
        get links_path
        assert_select "a", "Sign Up"
        assert_select "a", "Login"
    end

    test "User can be logged in" do
        sign_in users(:one)
        get links_path
        assert_select "a", "Profile"
        assert_select "button", "Logout"
        # assert_match "Profile", response.body
    end

  
end
