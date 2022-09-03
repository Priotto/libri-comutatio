class ChatroomPolicy < ApplicationPolicy
  class Scope < Scope
  end

  def show?
    true
    # record.trade.seller_book_id == user || record.trade.buyer_book_id
  end
end
