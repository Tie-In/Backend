FactoryGirl.define do
  factory :organization do
    name {Faker::Name.name}
    description {Faker::Name.description}
  end
end
