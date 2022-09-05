class TradePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where("seller_id = ? OR buyer_id = ?", user, user)
    end
  end

  def index?
    true
  end

  def create?
    true
  end

  def update?
    record.seller == user || record.buyer == user
  end

  def destroy?
    record.seller == user || record.buyer == user
  end
end
