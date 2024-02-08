module Favoritable
    extend ActiveSupport::Concern
    
    # estas clases nos permiten separar la lógica de los modelos
    # metodos asociados a favoritos
    included do
        def favorite! 
            favorites.create(user: Current.user)
        end
    
        def unfavorite!
            favorites.find_by(user: Current.user).destroy!
        end
    end
end