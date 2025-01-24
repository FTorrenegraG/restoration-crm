# spec/factories/ministry_roles.rb
FactoryBot.define do
  factory :ministry_role do
    name { "Test Role" }
    description { "This is a test role" }
    ministry { create(:ministry) }
  end
end
