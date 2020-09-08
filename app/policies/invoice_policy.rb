class InvoicePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin
        scope.order(created_at: :desc)
      else
        scope.where(approved: true).order(created_at: :desc)
      end
    end
  end

  def show?
    user == record.project.user || user.admin
  end

  def approve?
    user == record.project.dev_user
  end

  def edit?
    approve?
  end

  def update?
    approve?
  end

end
