Rails.application.routes.draw do
  # product roots 
  root "products#index"
  
  get "/products", to: "products#index" # products_path
  post "/products", to: "products#create" # products_path
  get "/products/new", to: "products#new", as: :new_product # new_product_path
  get "/product/:id", to: "products#show", as: :product # product_path
end
