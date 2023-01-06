class User < ApplicationRecord
    has_secure_password
    
    validates :username, presence: true, length: { in: 6..30 }, uniqueness: true
    validates :bio, length: { maximum: 300 }, allow_nil: true, presence: false
end
