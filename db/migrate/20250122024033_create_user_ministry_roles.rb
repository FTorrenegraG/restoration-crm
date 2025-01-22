class CreateUserMinistryRoles < ActiveRecord::Migration[8.0]
  def change
    create_table :user_ministry_roles do |t|
      t.references :user, null: false, foreign_key: true
      t.references :ministry, null: false, foreign_key: true
      t.references :ministry_role, null: false, foreign_key: true

      t.timestamps
    end
  end
end
