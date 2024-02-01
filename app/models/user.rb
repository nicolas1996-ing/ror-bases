class User < ApplicationRecord
    # method to encrypt password (bcrypt gem)
    has_secure_password

    # callback 
    before_save :downcase_attributes

    validates :email, presence: true, uniqueness: true,  format: {
        with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
        message: :invalid
      }
    validates :username, presence: true, uniqueness: true, length: { in: 3..15 }, format: { with: /\A[a-zA-Z0-9_\.]*\z/, message: "only allows letters, numbers, underscores and dots"}
    validates :password_digest, presence: true, length: { minimum: 6 }, allow_nil: false

    # relaciones bd 
    has_many :products
    has_many :favorites, dependent: :destroy # un usuario puede tener varios productos como favoritos

    private
    def downcase_attributes
        self.email.downcase!
        self.username.downcase!
    end
end
