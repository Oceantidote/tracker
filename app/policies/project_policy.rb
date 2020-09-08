class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      user.member_projects.includes(team_memberships: [user: [photo_attachment: [:blob]]]).all
    end
  end

  def show?
    user.member_projects.include?(record)
  end

  def new?
    true
  end

  def create?
    new?
  end

  def edit?
    user == record.user || user.admin
  end

  def update?
    edit?
  end

  def team_memberships?
    edit?
  end

  def destroy?
    edit?
  end
end
