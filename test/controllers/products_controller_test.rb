require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest

    def setup 
        # metodo definido en test/test_helper.rb
       login
    end
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
        assert_select ".product", 10 # 2 productos en la bd
        assert_select ".category", 10
    end

    test "render a list of products by category" do
        get products_path, params: { category_id: categories(:videogames).id }
        assert_select ".product", 7
        assert_response :success # status 200
    end

    test "render a list of products by min_price & max_price" do
        get products_path, params: { min_price: 150, max_price: 200 }
        assert_select ".product", 5
        assert_response :success # status 200
    end

    test "render a list of products by search params" do
        get products_path, params: { search: "product-1" }
        assert_select ".product", 0
        assert_response :success # status 200
    end

    test "render a list of products by order_by params: expensive" do
        get products_path, params: { order_by: "expensive" }
        assert_select ".product", 10
        assert_response :success # status 200
        assert_select ".products .product_detail h2", "Seat Panda clásico"
    end

    test "render a list of products by order_by params: cheapest" do
        get products_path, params: { order_by: "cheapest" }
        assert_select ".product", 10
        assert_response :success # status 200
        assert_select ".products .product_detail h2", "El hobbit"
    end
    
    # test 2.
    test "render detail product page" do 
        # products from fixture/products.yml
        # rails toma el id del producto de products(:ps4)
        get product_path(products(:ps4)) # .../products/1
        assert_response :success
        assert_select ".title_product", products(:ps4).title.capitalize
        assert_select ".description_product", products(:ps4).description
        assert_select ".price_product", "$ #{products(:ps4).price.to_s}"
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
            price: 100,
            category_id: categories(:videogames).id
        }}
        assert_redirected_to products_path
        assert_equal flash[:notice], "Producto creado exitosamente"
    end

    test "does not allow create a new product with null or empty fields" do
         post products_path, params: { product: {
            title: "",
            description: "this is a description",
            price: 10,
            category_id: categories(:videogames).id
         }}

         assert_response :unprocessable_entity
    end

    # edit 
    test "render edit product page" do  
        get edit_product_path(products(:ps4))
        assert_response :success
        assert_select "form"
    end

    test "allow update a product" do
        patch product_path(products(:ps4)), params: { product: {price: 200} }
        assert_redirected_to product_path(products(:ps4))
        assert_equal flash[:notice], "Producto actualizado exitosamente"
    end

    test "does no allow update product" do 
        patch product_path(products(:ps4)), params: { product: {title: ""} }
        assert_response :unprocessable_entity
    end
  
    test "can delete a product" do

        # un producto menos en la bd despues de ejecutar el bloque
        assert_difference("Product.count", -1) do   
            delete product_path(products(:ps4))
        end
        assert_redirected_to products_path
        assert_equal flash[:notice], "Producto eliminado exitosamente"
    end

end