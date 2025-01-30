# app/admin/application_controller.rb
module ActiveAdmin
  class ApplicationController < ::ApplicationController
    include Pundit

    private

    def pundit_policy_class
      case resource
      when ActiveAdmin::Page
        ActiveAdmin::PagePolicy
      else
        super
      end
    end
  end
end
