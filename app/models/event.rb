class Event < ApplicationRecord
  has_many :song_events, dependent: :destroy
  has_many :assignments, dependent: :restrict_with_error

  validates :name, presence: true
  validates :start_datetime, presence: true
  validates :end_datetime, presence: true
end
