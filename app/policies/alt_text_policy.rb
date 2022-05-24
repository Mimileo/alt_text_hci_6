class AltTextPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      if !user.nil? && (user.super_user? || user.referee?)
        scope.all
      end
    end
  end

  def new?
    user.present? && user.super_user == true || user.referee == true
  end

  def create?
    user.present? && user.super_user == true
  end

  def index?
    user.present? && user.super_user == true
  end

  def show
    true
  end

  def update?
     user.present? && user.super_user == true
  end

  def destroy?
    create?
  end

  

end