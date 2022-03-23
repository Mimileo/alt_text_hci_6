class AltPolicy < ApplicationPolicy

  def create?
    (user.present? && user.flag != true) || (user.present? && user.super_user == true)
  end

  def show?
    true
  end

  def new?
     create?
  end

  def update?
    create?
  end

  def destroy?
    (user.present? && @record.user_id == user.id) || (user.present? && user.super_user == true)
  end
end