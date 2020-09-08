class ListPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.includes({tasks: [{ users: :photo_attachment },:user_tasks, { periods: {user: :photo_attachment} }, { notes: :rich_text_content }]}, { project: { team_memberships: { user: :photo_attachment }}})
    end
  end

  def show?
    record.project.members.include?(user) || user.admin
  end
end
