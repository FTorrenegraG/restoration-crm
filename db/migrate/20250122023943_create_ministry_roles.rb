class CreateMinistryRoles < ActiveRecord::Migration[8.0]
  def change
    create_table :ministry_roles do |t|
      t.references :ministry, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.string :uni_key

      t.timestamps
    end
    add_index :ministry_roles, :uni_key, unique: true
  end
end
