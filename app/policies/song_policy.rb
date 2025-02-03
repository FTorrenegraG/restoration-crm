class SongPolicy
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

  def new?
    create?
  end

  def edit?
    update?
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

  Scope = Scopes::SongScope

  private

  def user_has_permission?
    user&.ministry_roles&.pluck(:uni_key).include? 'restoration-crm-administrador'
  end
end