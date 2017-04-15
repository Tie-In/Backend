FactoryGirl.define do
  factory :sprint do
    number Faker::Number.digit

    trait :ended do
        is_ended true
    end
  end
end
