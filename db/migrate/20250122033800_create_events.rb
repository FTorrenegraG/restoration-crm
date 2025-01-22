class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :start_datetime
      t.datetime :end_datetime
      t.string :location
      t.text :description
      t.integer :status

      t.timestamps
    end
  end
end
