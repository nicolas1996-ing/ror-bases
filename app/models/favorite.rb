class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :product

  # validaciones 

  # un usuario solo tener el mismo producto una vez marcado como favorito
  validates :user, uniqueness: { scope: :product }
end
