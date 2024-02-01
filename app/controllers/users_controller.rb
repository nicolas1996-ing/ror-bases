class UsersController < ApplicationController
    # protect_pages es un método definido en el concern authorization.rb
    skip_before_action :protect_pages, only: [:show]

    def show 
        # Parameters: {"id"=>"1"}
        # el ! al final del metodo where! indica que si no encuentra el registro arroja una excepcion
        # la excepcion es manejada en el controlador application_controller.rb
        @user = User.find_by!(id: params[:id])

        # filtros: app/queries/find_products.rb
        # en este caso los params son { user_id: @user.id }
        @products = FindProducts.new.call({user_id: @user.id}).load_async
        # paginación - scroll infinito
        @pagy, @products = pagy(@products, items: 10)
    end

end