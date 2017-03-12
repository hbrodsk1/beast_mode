class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :outlet
  has_many :children, class_name: "Comment", foreign_key: "parent_id"

  validates :body, :user, :outlet, presence: true
  validates :body, length: { in: 1..1000 }
end
