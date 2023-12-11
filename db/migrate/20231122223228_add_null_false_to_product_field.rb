class AddNullFalseToProductField < ActiveRecord::Migration[7.0]
  def change
    # change_column_null: no permite que el campo sea nulo
    change_column_null :products, :title, false
    change_column_null :products, :description, false
    change_column_null :products, :price, false
  end
end
