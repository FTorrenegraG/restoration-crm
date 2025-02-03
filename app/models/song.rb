class Song < ApplicationRecord
  has_many :song_events, dependent: :destroy

  validates :title, presence: true

  def self.ransackable_attributes(auth_object = nil)
    [ 'created_at', 'id', 'id_value', 'key', 'lyrics', 'performer', 'reference_link', 'sheet_music', 'song_type',
      'title', 'updated_at', 'vocals' ]
  end
end
