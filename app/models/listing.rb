class Listing < ApplicationRecord
  belongs_to :user
  has_many :purchases

  has_one_attached :photo
end
