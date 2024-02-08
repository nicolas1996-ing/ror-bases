require "test_helper"

class FavoritesControllerTest < ActionDispatch::IntegrationTest
    setup do 
        @user = users(:test)
        @product = products(:ram)
        @switch = products(:switch)
        login
    end

    test "should mark as favorite a product" do
        assert_difference('Favorite.count', 1) do
            post favorites_url(product_id: @product.id)
        end
        assert_redirected_to product_path(@product)
        assert_equal "Producto añadido a favoritos", flash[:notice]
        assert @product.favorites.exists?(user_id: @user.id)
    end

    test "should unmark as favorite a product" do
        assert_difference('Favorite.count', -1) do
            delete favorite_url(@switch.id)
        end
        assert_redirected_to product_path(@switch)
    end
end