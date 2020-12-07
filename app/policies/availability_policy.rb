class AvailabilityPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def update?
    user == record.lecture.user
  end

  def destroy?
    user == record.lecture.user
  end
end
