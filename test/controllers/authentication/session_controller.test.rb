require "test_helper"
class Authentication::SessionControllerTest < ActionDispatch::IntegrationTest
    def setup 
        @user = users(:one)
    end

    test "should get new session path" do
        get new_session_url
        assert_response :success
    end

    test "should create session by email" do  
        post sessions_path, params: { session: {login: @user.email, password: "test1234"}}
        assert_redirected_to products_url
    end

    test "should create session by username" do  
        post sessions_path, params: { session: {login: @user.username, password: "test1234"}}
        assert_redirected_to products_url
    end
    
    test "should logout" do 
        login 
        delete session_path(Current.user.id)
        assert_redirected_to products_url
        assert_nil session[:user_id]
        assert_equal flash[:notice], "usuario deslogueado exitosamente"
    end
end