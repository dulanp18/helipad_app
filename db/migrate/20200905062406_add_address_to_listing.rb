class AddAddressToListing < ActiveRecord::Migration[6.0]
  def change
    add_column :listings, :address, :text
  end
end
