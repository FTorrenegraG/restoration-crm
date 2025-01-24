# spec/factories/ministries.rb
FactoryBot.define do
  factory :ministry do
    name { "Test Ministry" }
    description { "This is a test ministry" }
  end
end
