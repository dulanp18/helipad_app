class Purchase < ApplicationRecord
  belongs_to :listing
  belongs_to :user
  has_one :review
  validates :status, inclusion: { in: ["pending", "accepted", "declined"] }
end
