class Category < ApplicationRecord
    validates :name, presence: true

    # relacion uno a muchos
    has_many :products, dependent: :destroy
end
