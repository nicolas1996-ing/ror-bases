class BasePolicy 
    # forma de acceder al atributo record desde las policies
    attr_reader :record 

    def initialize(record)
        @record = record
    end

    # comportamiento por defecto cuando no se declara un metodo en la policy pero que si existe el controlador
    def method_missing(m, *args, &block)
        # si el metodo que se llama es igual al nombre del controlador, entonces se retorna true
        # ejemplo: si el metodo que se llama es index, entonces se retorna true
        m == self.class.to_s.gsub("Policy", "").underscore
    end
end
