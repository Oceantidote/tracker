class TeamMembershipPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user == record.project.user || user.admin
  end

  def destroy?
    create?
  end
end
