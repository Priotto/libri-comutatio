class Book < ApplicationRecord
  belongs_to :user

  validates :description, presence: true

  scope :available, -> { where("available = ?", true) }

  def trade!
    self.update_attribute("available", false)
  end

  def self.get_book_attributes(title)
    response = Books.call(title)
    return response
  end
end
