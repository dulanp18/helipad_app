class ChangeDefaultOfPurchaseStatusToPending < ActiveRecord::Migration[6.0]
  def change
   change_column :purchases, :status, :string, default: 'pending'
  end
end
