class BookPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # scope.where(user: user)
      # Or scope.where("name LIKE 't%'")
      # Or user.admin? ? scope.all : scope.where(user: user)
    end
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    record.user == user
  end
end
