FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "test#{n}@example.com"}
    sequence(:username) {|n| "test#{n}"}
    password {Faker::Internet.password}
    firstname {Faker::Name.first_name}
    lastname {Faker::Name.last_name}
    phone_number {Faker::Company.duns_number}
  end

  factory :login_user, class: User do
    email "default@tiein.com"
    username "Default"
    password {Faker::Internet.password}
    auth_token "pvRffYX_XhPs8V8ovh8z"
    firstname "John"
    lastname "Doe"
    phone_number "123123123"
  end
end
