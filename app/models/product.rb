# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  price       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Product < ApplicationRecord
    # rails active_storage:install
    # rails db:migrate
    # tabla creada: active_storage_blobs
    has_one_attached :photo

    # validaciones del modelo
    validates :title, presence: true
    validates :description, presence: true
    validates :price, presence: true
end

# ========================
# create product 
# rails c
# Product.create(title: "Product 1", description: "Description 1", price: 100)
# ========================
