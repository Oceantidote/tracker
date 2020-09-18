class TaskPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    record.list.project.members.include?(user) || user.admin
  end

  def show?
    record.list.project.members.include?(user) || user.admin
  end

  def complete?
    show?
  end

  def create_quote_task?
    user.admin
  end

  def uncomplete?
    show?
  end
end
