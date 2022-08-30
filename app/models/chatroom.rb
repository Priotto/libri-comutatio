class Chatroom < ApplicationRecord
  has_many :messages
  belongs_to :transaction_chatroom, foreign_key: 'transaction_id', class_name: 'Transaction'
end
