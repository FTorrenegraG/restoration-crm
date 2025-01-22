class AddIndexToUserProfiles < ActiveRecord::Migration[8.0]
  def change
    add_index :user_profiles, :first_name
    add_index :user_profiles, :last_name
    add_index :user_profiles, :casa_r
    add_index :user_profiles, :other_details, using: :gin
  end
end
