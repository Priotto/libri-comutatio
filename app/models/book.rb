class Book < ApplicationRecord
  belongs_to :user
  has_many :trades, dependent: :destroy, foreign_key: 'seller_book_id'
  has_many :trades, dependent: :destroy, foreign_key: 'buyer_book_id'

  validates :description, presence: true

  scope :available, -> { where("available = ?", true) }

  def trade!
    self.update_attribute("available", false)
  end
end
