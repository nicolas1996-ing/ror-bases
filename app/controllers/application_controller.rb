class ApplicationController < ActionController::Base
    # logica de la clase manejada a través de concerns (app/controllers/concerns)
    include Authentication # concern authentication.rb
    include Authorization # concern authorization.rb
    include Pagy::Backend
    include Languages # concern languages.rb
    include Error # concern error.rb
end
