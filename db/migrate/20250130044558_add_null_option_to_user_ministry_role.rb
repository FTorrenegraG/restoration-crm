class AddNullOptionToUserMinistryRole < ActiveRecord::Migration[8.0]
  def change
    change_column_null :user_ministry_roles, :ministry_sub_role_id, true
  end
end
