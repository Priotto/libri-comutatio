class RemoveYearFromBooks < ActiveRecord::Migration[7.0]
  def change
    remove_column :books, :year, :integer
  end
end
