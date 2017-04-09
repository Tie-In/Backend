FactoryGirl.define do
  factory :retrospective do
    number Faker::Number.digit
    
    trait :in_progress do
        status :in_progress
    end

    trait :categorise do
        status :categorise
    end

    trait :done do
        status :done
    end
  end
end
