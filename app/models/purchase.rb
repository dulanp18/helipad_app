class Purchase < ApplicationRecord
  belongs_to :listing
  belongs_to :user
  belongs_to :review, optional: true
  validates :status, inclusion: { in: ["pending", "accepted", "declined"] }
end
