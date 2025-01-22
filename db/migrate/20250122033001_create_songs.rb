class CreateSongs < ActiveRecord::Migration[8.0]
  def change
    create_table :songs do |t|
      t.string :title
      t.string :performer
      t.string :key
      t.string :song_type
      t.string :reference_link
      t.string :lyrics
      t.string :sheet_music
      t.string :vocals

      t.timestamps
    end
  end
end
