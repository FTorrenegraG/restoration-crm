# app/policies/active_admin/page_policy.rb
module ActiveAdmin
  class PagePolicy
    attr_reader :user, :record

    def initialize(user, record)
      @user = user
      @record = record
    end

    def show?
      true
    end
  end
end
