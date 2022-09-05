class ChatroomPolicy < ApplicationPolicy
  class Scope < Scope
  end

  def show?
    record.trade.seller == user || record.trade.buyer == user
  end
end
