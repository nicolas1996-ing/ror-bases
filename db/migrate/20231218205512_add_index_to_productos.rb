class AddIndexToProductos < ActiveRecord::Migration[7.0]
  def change
    add_index :products, [:title,:description]
  end
end
