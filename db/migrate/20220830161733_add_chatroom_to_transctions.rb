class AddChatroomToTransctions < ActiveRecord::Migration[7.0]
  def change
    add_reference :transactions, :chatroom, null: false, foreign_key: true
  end
end
