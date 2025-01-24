require 'rails_helper'

RSpec.describe MinistryRole, type: :model do
  let(:ministry) { create(:ministry, name: "Test Ministry") }

  subject { build(:ministry_role, ministry: ministry) }

  it { should belong_to(:ministry) }
  it { should validate_presence_of(:name) }

  describe "uni_key validations" do
    before do
      allow_any_instance_of(MinistryRole).to receive(:generate_uni_key)
    end

    it { should validate_presence_of(:uni_key) }
  end

  it "generates a unique uni_key before validation" do
    role = build(:ministry_role, name: "Role 1", ministry: ministry)
    role.validate
    expect(role.uni_key).to eq("test-ministry-role-1")
  end

  it "does not generate uni_key if ministry is nil" do
    role = build(:ministry_role, ministry: nil, name: "Test Role")
    role.validate
    expect(role.uni_key).to be_nil
  end

  it "does not generate uni_key if name is blank" do
    role = build(:ministry_role, ministry: ministry, name: nil)
    role.validate
    expect(role.uni_key).to be_nil
  end

  it "does not overwrite uni_key if it is already set" do
    role = build(:ministry_role, ministry: ministry, name: "Test Role", uni_key: "custom-key")
    role.validate
    expect(role.uni_key).to eq("custom-key")
  end

  it "generates uni_key correctly when conditions are met" do
    role = build(:ministry_role, ministry: ministry, name: "Test Role")
    role.validate
    expect(role.uni_key).to eq("test-ministry-test-role")
  end
end
