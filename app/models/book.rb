class Book < ApplicationRecord
  belongs_to :user

  validates :description, presence: true

  scope :available, -> { where("available = ?", true) }

  def trade!
    self.update_attribute("available", false)
  end
end
