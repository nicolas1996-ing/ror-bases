# la clase padre BasePolicy recibe como parametro el objeto que se quiere validar
# y lo guarda en el atributo record
class ProductPolicy < BasePolicy
    def edit
        # record.user_id == Current.user.id 
        # owner? es un metodo declarado en la clase Product.model 
        record.owner?
    end

    def update 
        record.owner?
    end

    def destroy
        record.owner?
    end 
end