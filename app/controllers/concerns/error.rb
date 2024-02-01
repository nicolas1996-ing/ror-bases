module Error 
    extend ActiveSupport::Concern

    included do
         # manejo de errores
        rescue_from ActiveRecord::RecordNotFound do 
            redirect_to root_path, alert: t(".common.user_not_found")
        end
    end
end