class UserPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    user_has_permission?
  end

  def show?
    user_has_permission?
  end

  def create?
    user_has_permission?
  end

  def update?
    user_has_permission?
  end

  def destroy?
    user_has_permission?
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user&.ministry_roles&.pluck(:uni_key)&.include?('restoration-crm-administrador')
        scope.all
      else
        scope.none
      end
    end
  end

  private

  def user_has_permission?
    user&.ministry_roles&.pluck(:uni_key).include? 'restoration-crm-administrador'
  end
end
