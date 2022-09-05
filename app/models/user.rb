class User < ApplicationRecord
  has_many :trades
  has_many :books
  has_many :reviews
  has_many :chatrooms, through: :trades

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def full_name
    "#{firstname} #{lastname}"
  end
end
