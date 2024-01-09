class Authentication::UsersController < ApplicationController
    # salta la validacion de usuario logueado definida en app/controllers/application_controller.rb
    skip_before_action :protect_pages

    def new 
        # instancia de usuario vacia 
        @user = User.new
    end

    def create 
        @user = User.new(user_params)
        respond_to do |format|
            if @user.save
                # session is a rails method that stores the user_id in a cookie
                session[:user_id] = @user.id
                format.html { redirect_to products_path, notice: t(".success") }
            else
                format.html { render :new, status: :unprocessable_entity }
            end
        end
    end

    private 
    def user_params 
        params.require(:user).permit(:email, :username, :password)
    end
end