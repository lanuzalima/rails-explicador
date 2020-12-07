class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user != record.availability.lecture.user
  end

  def show?
    true
  end

  def destroy?
    user == record.user
  end
end
