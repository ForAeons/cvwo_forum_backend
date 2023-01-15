class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  validates :content, presence: true, length: { maximum: 3000 }
  validates :author, presence: true, length: { in: 6..30 }

  scope :in_order, -> { order(created_at: :desc) }
end
