class User < ApplicationRecord
  has_many :trades
  has_many :books
  has_many :reviews

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
