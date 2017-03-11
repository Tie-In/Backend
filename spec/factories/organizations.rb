FactoryGirl.define do
  factory :organization do
    sequence(:email) {|n| "test#{n}@example.com"}
    sequence(:username) {|n| "test#{n}"}
    password {Faker::Internet.password}
    firstname {Faker::Name.first_name}
    lastname {Faker::Name.last_name}
    phone_number {Faker::Company.duns_number}
  end
end
