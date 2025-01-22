class CreateSongEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :song_events do |t|
      t.references :event, null: false, foreign_key: true
      t.references :song, null: false, foreign_key: true

      t.timestamps
    end
  end
end
