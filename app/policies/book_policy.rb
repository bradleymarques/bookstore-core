class BookPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    record.user == user
  end

  def update?
    record.user == user
  end
end
