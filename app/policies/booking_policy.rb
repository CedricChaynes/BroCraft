class BookingPolicy < ApplicationPolicy
  def create?
    record.owner != user
  end

  def show
    owner? || renter?
  end

  def update?
    owner? || renter?
  end

  def permitted_attributes
      [:status]
    end
  end

  class Scope < Scope
    def resolve
      scope.where(owner? || renter?)
    end
  end

  private

  def owner?
    record.owner == user
  end

  def renter?
    record.renter == user
  end
end