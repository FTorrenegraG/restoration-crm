require 'rails_helper'

RSpec.describe MinistryRole, type: :model do
  let(:ministry) { create(:ministry) }

  before do
    described_class.create!(name: "Role 1", description: "Test Role", uni_key: "unique_key", ministry: ministry)
  end

  it { should validate_uniqueness_of(:uni_key) }

  it { should belong_to(:ministry) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
end
