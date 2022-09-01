class AddThumbnailToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :thumbnail, :string
  end
end
