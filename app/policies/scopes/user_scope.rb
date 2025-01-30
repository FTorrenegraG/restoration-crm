module Scopes
  class UserScope
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
end