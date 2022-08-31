class RemovePhotoFromBooks < ActiveRecord::Migration[7.0]
  def change
    remove_column :books, :photo, :string
  end
end
