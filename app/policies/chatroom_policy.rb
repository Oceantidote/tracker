class ChatroomPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(project_id: user.member_projects)
    end
  end

  def show?
    user.member_projects.include?(record.project) || user.admin
  end
end
