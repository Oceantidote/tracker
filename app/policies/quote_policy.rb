class QuotePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    record.list.project.members.include?(user)
  end

  def new?
  end

  def create?
    record.list.project.members.include?(user) && !user.admin
  end

  def edit?
  end

  def update?
  end

  def accept?
    record.list.project.user == user
  end

  def reject?
    accept?
  end

  def submit_for_acceptance?
    user.admin
  end

  def destroy?
  end

end
