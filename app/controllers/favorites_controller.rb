class FavoritesController < ApplicationController

    def create 
        puts "llegó al create"
        # Favorite.create(product_id: product.id, user_id: Current.user.id)
        # product.favorites.create(user: Current.user)
        product.favorite! # va al modelo de productos y crea el favorito
        redirect_to product_path(product), notice: t(".success")
    end

    def destroy
        puts "===================favorite-destroy==================="
        puts params[:id]
        # el id que se recibe es el id del producto
        @product = Product.find(params[:id])
        favorite = Favorite.where(product_id: @product.id, user_id: Current.user.id).first
        if favorite.destroy!
            redirect_to product_path(@product), notice: t(".success")
        else
            redirect_to product_path(@product), alert: t(".error")
        end
    end

    private 

    def product 
        # guardar en caché el producto para evitar hacer una consulta a la base de datos
        @product ||= Product.find(params[:product_id])
    end
end