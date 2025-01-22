class CreateMinistrySubRoles < ActiveRecord::Migration[8.0]
  def change
    create_table :ministry_sub_roles do |t|
      t.references :ministry_role, null: false, foreign_key: true
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
