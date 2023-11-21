class ProductsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create]

    # get "/products", to: "products#index"
    def index 
        # variable de instancia lista para usar en la vista
        @products = Product.all
        puts params # {"controller"=>"products", "action"=>"index"}
    end 

    # get "/products/:id", to: "products#show"
    def show
        # variable de instancia lista para usar en la vista
        @product = Product.find(params[:id])
        puts params # {"controller"=>"products", "action"=>"show", "id"=>"1"}
    end

    # get "/products/new", to: "products#new"
    def new 
        # crear un producto con todos los atributos vacios (nil)
        @product = Product.new
    end

    # post "/products", to: "products#create"
    def create
        @product = Product.new(product_params)

        if @product.save
            redirect_to products_path, notice: 'El producto fue publicado con éxito.'
        else
            render :new, status: :unprocessable_entity
        end
    end


    private 
    # captura de los params solo los valores especificados, lo demás es ignorado
    def product_params
        params.require(:product).permit(:title, :description, :price,)
    end
end

# ========================
# notas
# 1. los params son los parametros que se pasan por la url
# ========================