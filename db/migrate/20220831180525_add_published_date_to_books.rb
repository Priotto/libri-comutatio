class AddPublishedDateToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :published_date, :string
  end
end
