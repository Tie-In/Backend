FactoryGirl.define do
  factory :organization do
    name {Faker::Name.name}
    description "description"
  end
end
