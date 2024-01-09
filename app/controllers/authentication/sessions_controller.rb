class Authentication::SessionsController < ApplicationController
    # salta la validacion de usuario logueado definida en app/controllers/application_controller.rb
    skip_before_action :protect_pages

    def new 
    end

    def create 
        user = User.find_by("email = :login OR username = :login",{ login: params[:login] })
      
        # authenticate method is provided by has_secure_password
        if user && user.authenticate(params[:password])
            # session is a rails method that stores the user_id in a cookie
            session[:user_id] = user.id
            redirect_to products_path, notice: t('.login_success')
        else
            flash.now.alert = t('.login_failed')
            render :new
        end
    end  

    def destroy
        session.delete(:user_id)
        redirect_to products_path, notice: t('.logout_success')
    end
end