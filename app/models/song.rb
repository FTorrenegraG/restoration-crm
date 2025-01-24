class Song < ApplicationRecord
  has_many :song_events, dependent: :destroy

  validates :title, presence: true
end
