class Book < ApplicationRecord
  belongs_to :user

  scope :available, -> { where("available = ?", true) }
end
