class Outlet < ApplicationRecord
  ALLOWED_CATEGORIES = ["vent", "rant", "qualm"].freeze

  belongs_to :user
  has_many :comments

  validates :category, :title, :body, :urgency, :user, presence: true
  validates :title, length: { in: 1..60 }
  validates :body, length: { in: 1..1000 }
  validates :urgency, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
  validates :category, inclusion: { in: ALLOWED_CATEGORIES }
end
