require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:user_profiles).dependent(:destroy) }
  it { should have_many(:assignments).dependent(:destroy) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should allow_value("test@example.com").for(:email) }
end
