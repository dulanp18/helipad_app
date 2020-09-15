class Listing < ApplicationRecord
  belongs_to :user
  has_many :purchases
  has_many :reviews, through: :purchases
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  has_one_attached :photo

  include PgSearch::Model

  pg_search_scope :search_by_title,
    against: [:title],
    using: {
      tsearch: { prefix: true }
    }

  # def self.search(search)
  #   where("title LIKE ?", "%#{search.capitalize}%")
  # end

  # def title=(s)
  #   super s.titlecase
  # end
end
