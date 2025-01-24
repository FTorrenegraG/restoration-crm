require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should have_many(:assignments).dependent(:restrict_with_error) }
  it { should have_many(:song_events).dependent(:destroy) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:start_datetime) }
  it { should validate_presence_of(:end_datetime) }
end
