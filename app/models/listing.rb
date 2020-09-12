class Listing < ApplicationRecord
  belongs_to :user
  has_many :purchases
  has_many :reviews, through: :purchases

  has_one_attached :photo

  def self.search(search)
    where("title LIKE ?", "%#{search.capitalize}%")
  end

  def title=(s)
    super s.titlecase
  end
end
