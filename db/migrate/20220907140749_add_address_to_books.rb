class AddAddressToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :address, :string
  end
end
