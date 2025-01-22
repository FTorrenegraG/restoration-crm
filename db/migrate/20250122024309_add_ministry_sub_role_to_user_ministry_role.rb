class AddMinistrySubRoleToUserMinistryRole < ActiveRecord::Migration[8.0]
  def change
    add_reference :user_ministry_roles, :ministry_sub_role, null: false, foreign_key: true
  end
end
