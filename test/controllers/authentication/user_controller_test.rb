require "test_helper"
class Authentication::UsersControllerTest < ActionDispatch::IntegrationTest
    test "should get new user path" do
        get new_user_url
        assert_response :success
    end

    test "should create user" do  
        assert_difference("User.count") do
            post users_path, params: { user: {email: "test_test@gmail.com", username: "test_test", password: "test1234"}}
         end  
        assert_redirected_to products_path
    end
end