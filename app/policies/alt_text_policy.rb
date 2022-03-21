class AltTextPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      if user.super_user?
        scope.all
      end
    end
  end

  def new?
    user.present? && user.super_user == true
  end

  def create?
    user.present? && user.super_user == true
  end

  def index?
    user.present? && user.super_user == true
  end

  def show
    new?
  end

  def update?
     user.present? && user.super_user == true
  end

  def destroy?
    create?
  end

  

end