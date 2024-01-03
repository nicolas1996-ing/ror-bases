class ProductsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create]

    # get "/products", to: "products#index"
    def index 
        # puts "================================"
        # puts params
        # # query_params (...url?query_param&query_param) 
        # # http://localhost:3000/?category_id=10 ... params ={"category_id"=>"10", "controller"=>"products", "action"=>"index"}
        # puts "================================"
        # puts params[:order_by].present?

        # query_params 
        search = params[:search]
        category_id = params[:category_id]
        category = Category.find_by(id: category_id)

        min_price = params[:min_price] 
        max_price = params[:max_price]
        
        # variable de instancia lista para usar en la vista
        @categories = Category.all.order(name: :asc).load_async

        # filtros 
        if category.present?
            @products = Product.all
                               .with_attached_photo
                               .where(category_id: category_id)
                               .load_async
        elsif max_price.present? && min_price.blank?
            max_price = max_price.to_i
            @products = Product.all
                                .with_attached_photo
                                .where("price >= ?", max_price)
                                .load_async
        elsif min_price.present? && max_price.blank?
            min_price = min_price.to_i
            @products = Product.all
                                .with_attached_photo
                                .where("price <= ?", min_price)
                                .load_async
        elsif min_price.present? && max_price.present?
           

            min_price = min_price.to_i
            @products = Product.all
                                .with_attached_photo
                                .where("price >= ? AND price <= ?", min_price, max_price)
                                .load_async
        elsif search.present? && !search.blank?
            @products = Product.where("title like ?", "%#{search}%").with_attached_photo.order(created_at: :desc).load_async
       
        else
            @products = Product.all.with_attached_photo.load_async
        end

        # ordenar resultados
        # fetch(params[:order_by]&.to_sym, "created_at DESC") &: si parametro existe haga lo siguiente
        # ORDER_BY constante definida en el modelo Product
        @products = @products.order(Product::ORDER_BY.fetch(params[:order_by]&.to_sym, "created_at DESC"))
        
        # paginación - scroll infinito
        @pagy, @products = pagy(@products, items: 10)
    end 
end
