class Book < ApplicationRecord
  belongs_to :user
  has_many :trades, dependent: :destroy, foreign_key: 'seller_book_id'
  has_many :trades, dependent: :destroy, foreign_key: 'buyer_book_id'

  validates :description, presence: true

  scope :available, -> { where("available = ?", true) }

  def trade!
    self.update_attribute("available", false)
  end

  include PgSearch::Model
  pg_search_scope :search_books,
  against: [ :title, :synopsis, :author, :year, :description, :rating ],
  using: {
    tsearch: { prefix: true }
  }

  def self.get_book_attributes(title)
    response = Books.call(title)
    return response
  end
end
