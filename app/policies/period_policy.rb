class PeriodPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.admin
  end

  def update?
    user == record.user
  end

  def show?
    record.task.list.project.members.include?(user) || user.admin
  end
end
