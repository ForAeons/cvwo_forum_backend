class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  
  validates :title, presence: true, length: { maximum: 300 }
  validates :content, presence: true, length: { maximum: 5000 }
  validates :author, presence: true, length: { in: 6..30 }

  scope :recent, -> { order(updated_at: :desc) }
end
