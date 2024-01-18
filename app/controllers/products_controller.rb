class ProductsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create]

    # saltar la validacion de usuario logueado definida en app/controllers/application_controller.rb
    # y solo dejarla activa para los metodos index y show
    skip_before_action :protect_pages, only: [:index, :show]

    # get "/products", to: "products#index"
    def index 
        # query_params (...url?query_param&query_param) 
        # http://localhost:3000/?category_id=10 ... params ={"category_id"=>"10", "controller"=>"products", "action"=>"index"}

        # variable de instancia lista para usar en la vista
        @categories = Category.all.order(name: :asc).load_async
        # filtros: app/queries/find_products.rb
        @products = FindProducts.new.call(product_params_index).load_async
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
        # crea producto y lo asocia al usuario logueado. forma 1.
        # Current.user: app/controllers/concerns/current.rb
        # @product = Current.user.products.new(product_params)

        # crea producto y lo asocia al usuario logueado. forma 2. ( revisar modelo product.rb)
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
        # policies personalizadas - app/controllers/application_controller.rb
        # todos los metodos de application_controller.rb son heredados y se ejecutan antes de los metodos de los controladores
        authorize! product 
 
        # params: {"controller"=>"products", "action"=>"edit", "id"=>"1"}
        @product = product
    end

    def update
        # solo los usuarios que crearon el producto pueden editarlo
        # polices personalizadas - app/controllers/application_controller.rb
        authorize! product 

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
        # solo los usuarios que crearon el producto pueden eliminarlo 
        authorize! product 

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

    # strong params: solo los valores especificados (especificados), lo demás es ignorado
    def product_params_index 
        params.permit(:category_id, :min_price, :max_price, :search, :order_by, :page)
    end

    def product 
        @product ||= Product.find(params[:id])
    end
end

# ========================
# notas
# 1. los params son los parametros que se pasan por la url
# ========================