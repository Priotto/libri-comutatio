class AddReferencesToReviews < ActiveRecord::Migration[7.0]
  def change
    add_reference :reviews, :receiver, null: false, foreign_key: { to_table: :users }
    add_reference :reviews, :sender, null: false, foreign_key: { to_table: :users }
    add_reference :reviews, :order, index: true, foreign_key: { to_table: :transactions }
  end
end
