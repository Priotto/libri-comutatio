class Book < ApplicationRecord
  belongs_to :user
  has_many :trades, dependent: :destroy, foreign_key: 'seller_book_id'
  has_many :trades, dependent: :destroy, foreign_key: 'buyer_book_id'
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?


  scope :available, -> { where("available = ?", true) }

  def trade!
    self.update_attribute("available", false)
  end

  include PgSearch::Model
  pg_search_scope :search_books,
  against: [ :title, :synopsis, :author, :published_date, :description, :rating ],
  using: {
    tsearch: { prefix: true }
  }

  def self.get_book_attributes(title)
    response = Books.call(title)
    return response
  end

  def self.build(attr={})
    book = Book.new(attr)
    return book
  end
end
