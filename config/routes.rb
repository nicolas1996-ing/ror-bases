Rails.application.routes.draw do
  #  dentro de controllers se crea carpeta authentication y dentro de ella users_controller.rb
  #  en app/views/authentication/users/new.html.erb se crea la vista para el metodo new del controlador
  namespace :authentication, path: '', as: '' do
    resources :users, only: [:new, :create], path: '/register', path_names: { new: "/" } # http://localhost:3000/users/new
    resources :sessions, only: [:new, :create, :destroy], path: "login", path_names: { new: "/" } # http://localhost:3000/login

    # path: '/register', path_names: { new: "/" } aplica solo para la accion new 
    # cuando el usuario ingresa a http://localhost:3000/register  se renderiza la vista new.html.erb del controlador users
    # cuando el usuario ingresa a http://localhost:3000/login se renderiza la vista new.html.erb del controlador sessions
  end

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
