class User < ApplicationRecord
    has_secure_password
    has_many :comments, dependent: :destroy
    has_many :posts, dependent: :destroy
    
    validates :username, presence: true, length: { in: 6..30 }, uniqueness: true
    validates :bio, length: { maximum: 300 }, allow_nil: true, presence: false
end
