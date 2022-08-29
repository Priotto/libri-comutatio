class Book < ApplicationRecord
  belongs_to :user

  scope :available, -> { where("available = ?", true) }

  def trade!
    self.update_attribute("available", false)
  end
end
