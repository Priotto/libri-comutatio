class Review < ApplicationRecord
  belongs_to :trade
  belongs_to :receiver, foreign_key: 'receiver_id', class_name: 'User'
  belongs_to :sender, foreign_key: 'sender_id', class_name: 'User'

  has_many :books, through: :trades

  validates :score, numericality: { only_integer: true }
  validates :score, length: { in: 1..5 }
end
