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
    has_many :favorites, dependent: :destroy # un producto le puede gustar a varias personas


    # belongs_to :user
    belongs_to :user, default: -> { Current.user } # forma 2. para asociar el usuario actual a un producto que se quiere crear

    # validaciones del modelo
    validates :title, presence: true
    validates :description, presence: true
    validates :price, presence: true

    # constantes del modelo 
    ORDER_BY = {
        newest: "created_at DESC",
        oldest: "created_at ASC",
        expensive: "price DESC",
        cheapest: "price ASC"
    }

    def owner?
        user_id == Current.user.id
    end
end

# ========================
# create product 
# rails c
# Product.create(title: "Product 1", description: "Description 1", price: 100)
# ========================
