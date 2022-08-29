class Transaction < ApplicationRecord
  has_many :reviews

  belongs_to :buyer, foreign_key: 'buyer_id', class_name: 'User'
  belongs_to :seller, foreign_key: 'seller_id', class_name: 'User'
  belongs_to :seller_book, foreign_key: 'seller_book_id', class_name: 'Book'
  belongs_to :buyer_book, foreign_key: 'buyer_book_id', class_name: 'Book'

  validates :seller_book, uniqueness: { scope: :buyer_book }
end
