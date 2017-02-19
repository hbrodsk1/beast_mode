class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :outlet

  validates :body, :user, :outlet, presence: true
  validates :body, length: { in: 1..1000 }
end
