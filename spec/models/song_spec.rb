require 'rails_helper'

RSpec.describe Song, type: :model do
  it { should have_many(:song_events).dependent(:destroy) }
  it { should validate_presence_of(:title) }
end
