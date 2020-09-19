class AddPurchaseIdToReview < ActiveRecord::Migration[6.0]
  def change
    add_reference :reviews, :purchase, foreign_key: true
  end
end
