class Outlet < ApplicationRecord
  belongs_to :user

  validates :category, :title, :body, :urgency, presence: true
  validates :title, length: { in: 1..60 }
  validates :body, length: { in: 1..1000 }
  validates :urgency, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
  validates :category, inclusion: { in: ['vent', 'rant', 'qualm'] }
end
