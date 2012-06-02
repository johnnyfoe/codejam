FactoryGirl.define do
  factory :user do
    sequence(:first_name) { |n| "Example #{n}" }
    sequence(:surname) { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password "foobar"
    password_confirmation "foobar"
    
    factory :admin do
      admin true
    end
  end
  factory :project do
    sequence(:name) { |n| "Project #{n}" }
  end
end