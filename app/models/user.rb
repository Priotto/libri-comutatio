class User < ApplicationRecord
  has_many :trades
  has_many :books
  has_many :reviews
  has_many :chatrooms, through: :trades

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
