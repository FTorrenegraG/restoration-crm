require 'rails_helper'

RSpec.describe Ministry, type: :model do
  it { should have_many(:ministry_roles).dependent(:destroy) }
  it { should have_many(:user_ministry_roles).dependent(:restrict_with_error) }
  it { should validate_presence_of(:name) }
end
