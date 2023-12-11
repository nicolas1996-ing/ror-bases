require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
    # test 1.
    test "render a list of products" do
        # .../products
        get products_path  

        # test 1.1. estamos esperando que la respuesta sea exitosa
        assert_response :success # status 200

        # test 1.2
        ## bd para test: fixture/products.yml
        ## buscar la clase .product en la vista show.product
        ## assert_select: que queremos buscar en la vista ( html tag, class, id, etc)
        assert_select ".product", 2 # 2 productos en la bd
    end

    # test 2.
    test "render detail product page" do 
        # products from fixture/products.yml
        # rails toma el id del producto de products(:one)
        get product_path(products(:one)) # .../products/1
        assert_response :success
        assert_select ".title_product", products(:one).title.capitalize
        assert_select ".description_product", products(:one).description
        assert_select ".price_product", "$ #{products(:one).price.to_s}"
    end

    test "render new product page" do
        get new_product_path
        assert_response :success
        # se debe renderizan una etiqueta form
        assert_select "form"
    end

    test "allow create a new product" do 
        # post "/products", to: "products#create" # products_path    
        post products_path, params: { product: {
            title: "new product test",
            description: "new product description",
            price: 100
        }}
        assert_redirected_to products_path
        assert_equal flash[:notice], "Producto creado exitosamente"
    end

    test "does not allow create a new product with null or empty fields" do
         post products_path, params: { product: {
            title: "",
            description: "this is a description",
            price: 10
         }}

         assert_response :unprocessable_entity
    end

    # edit 
    test "render edit product page" do  
        get edit_product_path(products(:one))
        assert_response :success
        assert_select "form"
    end

    test "allow update a product" do
        patch product_path(products(:one)), params: { product: {price: 200} }
        assert_redirected_to product_path(products(:one))
        assert_equal flash[:notice], "Producto actualizado exitosamente"
    end

    test "does no allow update product" do 
        patch product_path(products(:one)), params: { product: {title: ""} }
        assert_response :unprocessable_entity
    end
  
    test "can delete a product" do

        # un producto menos en la bd despues de ejecutar el bloque
        assert_difference("Product.count", -1) do   
            delete product_path(products(:one))
        end
        assert_redirected_to products_path
        assert_equal flash[:notice], "Producto eliminado exitosamente"
    end
end