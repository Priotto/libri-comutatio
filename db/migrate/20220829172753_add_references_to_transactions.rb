class AddReferencesToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_reference :trades, :seller, index: true, foreign_key: { to_table: :users }
    add_reference :trades, :buyer, index: true, foreign_key: { to_table: :users }
    add_reference :trades, :seller_book, index: true, foreign_key: { to_table: :books }
    add_reference :trades, :buyer_book, index: true, foreign_key: { to_table: :books }
  end
end
