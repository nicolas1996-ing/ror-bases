# la clase padre BasePolicy recibe como parametro el objeto que se quiere validar
# y lo guarda en el atributo record
# new(record) ... va directamente al initialize de la clase padre BasePolicy
class CategoryPolicy < BasePolicy
    def index
        Current.user.admin?
    end

    def show 
        Current.user.admin?
    end

    def new
        Current.user.admin?
    end

    def create
        Current.user.admin? 
    end

    def edit 
        Current.user.admin?
    end

    def update
        Current.user.admin?
    end

    def destroy 
        Current.user.admin?
    end
end