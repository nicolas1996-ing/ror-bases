# ruby g model Favorite user:references product:references
class CreateFavorites < ActiveRecord::Migration[7.0]
  def change
    # references is a shortcut to create a foreign key
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end

    # Add index to prevent duplicate favorites
    # un usuario solo tener el mismo producto una vez marcado como favorito 
    # investigar mas sobre esto: add_index - constraints
    # basicamente no pueden existir dos registros con el mismo user_id y product_id
    add_index :favorites, %i[user_id product_id], unique: true, unique: true
  end
end
