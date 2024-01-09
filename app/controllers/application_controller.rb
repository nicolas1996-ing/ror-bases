class ApplicationController < ActionController::Base
    include Pagy::Backend
    
    # detectar idioma del navegador
    around_action :switch_locale
    before_action :set_current_user
    before_action :protect_pages

    def switch_locale
        locale = params[:locale] || I18n.default_locale
        I18n.with_locale(locale) do
            yield
        end
    end

    private 
    # antes de ejecutar cualquier accion de controlador, se ejecuta este metodo
    def set_current_user 
        # forma 1. para guardar usuario actual 
        # @current_user = User.find(session[:user_id]) if session[:user_id]
        # ================================================================
        # forma 2. para guardar usuario actual
        # concern current.rb , models/concerns/current.rb
        Current.user = User.find(session[:user_id]) if session[:user_id]
    end

    def protect_pages 
        # si no hay usuario logueado, redireccionar a la pagina de login
        redirect_to new_session_path, alert: t("common.not_logged_in") unless Current.user
    end
end
