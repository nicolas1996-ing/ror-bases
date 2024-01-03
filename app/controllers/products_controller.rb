class ProductsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create]

    # get "/products", to: "products#index"
    def index 
        # query_params (...url?query_param&query_param) 
        # http://localhost:3000/?category_id=10 ... params ={"category_id"=>"10", "controller"=>"products", "action"=>"index"}

        # variable de instancia lista para usar en la vista
        @categories = Category.all.order(name: :asc).load_async
        # filtros: app/queries/find_products.rb
        @products = FindProducts.new.call(params).load_async
        # paginación - scroll infinito
        @pagy, @products = pagy(@products, items: 10)
    end 

    # get "/products/:id", to: "products#show"
    def show
        # variable de instancia lista para usar en la vista
        @product = Product.find(params[:id])
        puts params # {"controller"=>"products", "action"=>"show", "id"=>"1"}
    end

    # new trabaja con create
    # get "/products/new", to: "products#new"
    def new 
        # crear un producto con todos los atributos vacios (nil)
        @product = Product.new
    end

    # post "/products", to: "products#create"
    def create
        @product = Product.new(product_params)
        if @product.save
            # flash: mensaje que se muestra una sola vez y que estara disponible en la siguiente vista (products#index)
            redirect_to products_path, notice: t(".success")
        else
            # renderiza el formulario con los errores, status 422
            render :new, status: :unprocessable_entity, alert: t(".error")
        end
    end

    # edit trabaja con update 
    def edit
        # params: {"controller"=>"products", "action"=>"edit", "id"=>"1"}
        @product = product
    end

    def update
        puts "params: #{params}" # {"controller"=>"products", "action"=>"update", "id"=>"1", "product"=>{"title"=>"Producto 1", "description"=>"Descripción del producto 1", "price"=>"100"}, "commit"=>"Actualizar Producto", "controller"=>"products"}
        puts "params.product put request: #{params[:product]}" # {"title"=>"Producto 1", "description"=>"Descripción del producto 1", "price"=>"100"}
        @product = product
        if @product.update(product_params)
            redirect_to product_path(@product), notice: t(".success")
        else
            render :edit, status: :unprocessable_entity, alert: t(".error")
        end
    end

    def destroy
        @product = product
        if @product.destroy
            redirect_to products_path, notice: t(".success"), status: :see_other
        else
            redirect_to products_path, alert: t(".error"), status: :unprocessable_entity
        end
    end

    private 
    # captura de los params solo los valores especificados (especificados), lo demás es ignorado
    def product_params
        params.require(:product).permit(:title, :description, :price, :photo, :category_id, :search, :order_by)
    end

    def product 
        @product ||= Product.find(params[:id])
    end
end

# ========================
# notas
# 1. los params son los parametros que se pasan por la url
# ========================