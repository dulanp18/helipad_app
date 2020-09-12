class Purchase < ApplicationRecord
  belongs_to :listing
  belongs_to :user
  validates :status, inclusion: { in: ["pending", "accepted", "declined"] }
end
