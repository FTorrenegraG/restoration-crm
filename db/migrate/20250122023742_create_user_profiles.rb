class CreateUserProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :user_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.date :birth_date
      t.string :casa_r
      t.jsonb :other_details

      t.timestamps
    end
  end
end
