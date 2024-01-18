module Authorization 
    extend ActiveSupport::Concern
    included do
        # =================== policies personalizadas ===================
        # la excepcion se ejecuta cuando no se cumple la condicion
        # la excepcion provoca que se ejecute el rescue_from
        class NotAuthorizedError < StandardError; end 
        rescue_from NotAuthorizedError do 
            # unless = cuando no ... 
            redirect_to products_path, alert: t("common.not_authorized")
        end

        private 
        
        def authorize! (record = nil) 
            # =================== policies personalizadas ===================
            # todos son metodos de rails: 
            #   -> controller_name: nombre del controlador en minusculas
            #   -> singularize: convierte el nombre del controlador en singular
            #   -> classify: convierte el string en una clase
            #   -> constantize: convierte el string en una constante
            #   -> send: ejecuta el metodo ( existente en la clase ) que se pasa como parametro
            #   -> action_name: nombre de la accion del controlador en minusculas
            # ejemplo: ProductPolicy.new.index
            # las policies se encuentran en app/policies
            is_allowed = "#{controller_name.singularize}Policy".classify.constantize.new(record).send(action_name)
            raise NotAuthorizedError unless is_allowed
        end
        # =================== policies personalizadas ===================
    end
end
