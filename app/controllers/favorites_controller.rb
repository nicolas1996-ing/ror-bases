class FavoritesController < ApplicationController

    def create 
        puts "llegó al create"
        Favorite.create(product_id: product.id, user_id: Current.user.id)
        redirect_to product_path(product), notice: "Product marked as favorited!"
    end

    private 

    def product 
        # guardar en caché el producto para evitar hacer una consulta a la base de datos
        @product ||= Product.find(params[:product_id])
    end
end