class AddReferencesToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_reference :transactions, :seller, index: true, foreign_key: { to_table: :users }
    add_reference :transactions, :buyer, index: true, foreign_key: { to_table: :users }
    add_reference :transactions, :seller_book, index: true, foreign_key: { to_table: :books }
    add_reference :transactions, :buyer_book, index: true, foreign_key: { to_table: :books }
  end
end
