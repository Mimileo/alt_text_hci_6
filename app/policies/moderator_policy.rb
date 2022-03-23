class ModeratorPolicy < ApplicationPolicy

  def new?
    (user.present? && user.super_user == true)
  end

  def show?
    new?
  end

  def index?
    new?
  end

  def create?
    new?
  end

  def update?
    new?
  end

  def destroy?
    new?
  end
end