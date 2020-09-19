class RemoveReviewIdFromPurchases < ActiveRecord::Migration[6.0]
  def change
    remove_column :purchases, :review_id
  end
end
