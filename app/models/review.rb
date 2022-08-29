class Review < ApplicationRecord
  belongs_to :transaction
  belongs_to :receiver, foreign_key: 'receiver_id', class_name: 'User'
  belongs_to :sender, foreign_key: 'sender_id', class_name: 'User'

  has_many :books, through: :transactions
end
