class Review < ApplicationRecord
  belongs_to :order, foreign_key: 'order_id', class_name: 'Transaction'
  belongs_to :receiver, foreign_key: 'receiver_id', class_name: 'User'
  belongs_to :sender, foreign_key: 'sender_id', class_name: 'User'

  has_many :books, through: :transactions
end
