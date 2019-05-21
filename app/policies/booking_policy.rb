class BookingPolicy < ApplicationPolicy
  def create?
    record.owner != user
  end

  def show
    (record.owner == user) || (record.renter == user)
  end

  def update?
    true
  end

  def permitted_attributes
    if owner?
      [:status]
    elsif renter?
      [:status, :start_date, :end_date]
    end
  end

  class Scope < Scope
    def resolve
      scope.where(owner? || record.renter == user)
    end
  end

  private

  def owner?
    record.owner == user
  end
end
