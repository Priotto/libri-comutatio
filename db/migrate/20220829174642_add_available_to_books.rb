class AddAvailableToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :available, :boolean, default: true, null: false
  end
end
