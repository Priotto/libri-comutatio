class RemoveYearAndAddDateToBooks < ActiveRecord::Migration[7.0]
  def self.up
    remove_column :books, :year
  end
  def self.down
    add_column :books, :published_date, :string
  end
end
