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
    # gema: pg_search
    include PgSearch::Model
    pg_search_scope :search_full_text, against: {
        title: 'A',
        description: 'B'
    }

    # rails active_storage:install
    # rails db:migrate
    # tabla creada: active_storage_blobs
    has_one_attached :photo
    belongs_to :category

    # validaciones del modelo
    validates :title, presence: true
    validates :description, presence: true
    validates :price, presence: true

    ORDER_BY = {
        newest: "created_at DESC",
        oldest: "created_at ASC",
        expensive: "price DESC",
        cheapest: "price ASC"
    }
end

# ========================
# create product 
# rails c
# Product.create(title: "Product 1", description: "Description 1", price: 100)
# ========================
