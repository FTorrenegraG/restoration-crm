require 'rails_helper'

RSpec.describe UserProfile, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:birth_date) }
end
