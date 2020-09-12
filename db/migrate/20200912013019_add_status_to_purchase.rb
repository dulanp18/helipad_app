class AddStatusToPurchase < ActiveRecord::Migration[6.0]
  def change
    add_column :purchases, :status, :string
  end
end
