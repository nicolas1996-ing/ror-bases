Rails.application.routes.draw do
  resources :categories, except: :show
  # product roots 
  root "products#index"
  
  # # listar productos
  # get "/products", to: "products#index" # products_path
  # get "/product/:id", to: "products#show", as: :product # product_path

  # # crear un producto
  # get "/products/new", to: "products#new", as: :new_product # new_product_path
  # post "/products", to: "products#create" # products_path

  # # editar un producto
  # get "/product/:id/edit", to: "products#edit", as: :edit_product # edit_product_path
  # patch "/product/:id", to: "products#update" # product_path

  # # delete un producto
  # delete "/product/:id", to: "products#destroy", as: :delete_product # delete_product_path

  resources :products 
end
