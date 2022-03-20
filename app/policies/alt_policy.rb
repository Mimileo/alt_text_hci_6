class AltPolicy < ApplicationPolicy

  def new?
    (user.present? && @record.user_id == user.id) || (user.present? && user.super_user == true) 
  end

  def show?
    new?
  end

  def create?
    create?
  end

  def update?
    create?
  end

  def destroy?
    (user.present? && @record.user_id == user.id) || (user.present? && user.super_user == true)
  end
end