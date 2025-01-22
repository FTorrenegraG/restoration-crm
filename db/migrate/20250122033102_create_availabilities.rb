class CreateAvailabilities < ActiveRecord::Migration[8.0]
  def change
    create_table :availabilities do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :start_datetime
      t.datetime :end_datetime
      t.string :reason

      t.timestamps
    end
  end
end
