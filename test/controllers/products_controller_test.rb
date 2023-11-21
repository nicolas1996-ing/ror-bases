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
        post products_path, params:{
            title: "new product test",
            description: "new product description",
            price: 100
        }
        
        # get "/products", to: "products#index"
        assert_redirected_to products_path
    end
end