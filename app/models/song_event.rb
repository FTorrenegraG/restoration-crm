class SongEvent < ApplicationRecord
  belongs_to :event
  belongs_to :song

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "event_id", "id", "id_value", "song_id", "updated_at"]
  end
end
