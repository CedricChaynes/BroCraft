class ToolPolicy < ApplicationPolicy
  def create?
    true
  end

  def owner_index
    record.owner == user
  end

  def search?
    true
  end

  def filter?
    true
  end

  def show?
    true
  end

  def new?
    true
  end

  def edit?
    record.owner == user
  end

  def update?
    record.owner == user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
