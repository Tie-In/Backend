FactoryGirl.define do
  factory :project do
    name {Faker::Name.name}
    description "description"
  end
end
