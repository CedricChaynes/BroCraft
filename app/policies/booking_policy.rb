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

  def approve?
    owner? || renter?
  end

  def reject?
    owner? || renter?
  end

  def permitted_attributes
      [:start_date, :end_date, :status]
  end
end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  private

  def owner?
    record.owner == user
  end

  def renter?
    record.renter == user
  end


