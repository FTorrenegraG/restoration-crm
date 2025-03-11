class Event < ApplicationRecord
  has_many :song_events, dependent: :destroy
  has_many :songs, through: :song_events
  has_many :assignments, dependent: :restrict_with_error

  validates :name, presence: true
  validates :start_datetime, presence: true
  validates :end_datetime, presence: true

  accepts_nested_attributes_for :songs

  attr_accessor :song_search, :search_results, :selected_song_ids

  def self.ransackable_attributes(auth_object = nil)
    [ 'created_at', 'description', 'end_datetime', 'id', 'id_value', 'location', 'name', 'start_datetime', 'status',
'updated_at' ]
  end

  def self.ransackable_associations(auth_object = nil)
    ["assignments", "song_events", "songs"]
  end
end
