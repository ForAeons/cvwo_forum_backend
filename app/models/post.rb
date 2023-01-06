class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  
  validates :title, presence: true, length: { maximum: 300 }
  validates :content, presence: true, length: { maximum: 5000 }
  validates :author, presence: true, length: { in: 6..30 }

  scope :recent, -> { order(created_at: :desc) }
end
