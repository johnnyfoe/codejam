FactoryGirl.define do
  factory :user do
    sequence(:first_name) { |n| "Example #{n}" }
    sequence(:surname) { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    sequence(:pseudonym) { |n| "User_#{n}"}
    password "foobar"
    password_confirmation "foobar"
    
    
    factory :admin do
      admin true
    end
  end
  factory :project do
    sequence(:name) { |n| "Project #{n}" }
	sequence(:status) { |n| "Status #{n}" }
	sequence(:tagline) { |n| "Tagline #{n}" }
	sequence(:description) { |n| "Description #{n}" }
  end
  
   factory :rating do
    effort 2
	code_quality 2
	communication_skills 1
	effort_just "lazy"
	code_quality_just "messy code, poorly commented"
	communication_skills_just "never spoke"
	general "poor programmer, would not recommend"
	user
	project
  end
end