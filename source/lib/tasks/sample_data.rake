namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(first_name: "Example",
      surname: "User",
      email: "example@railstutorial.org",
      password: "foobar",
      password_confirmation: "foobar",
	  pseudonym: "admin1")
    admin.toggle!(:admin)
    
    99.times do |n|
      first_name = Faker::Name.name
      second_name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!(first_name: first_name,
        surname: second_name,
        email: email,
        password: password,
        password_confirmation: password,
		pseudonym: "test#{n}")
	end
	users = User.all(limit: 6)
    50.times do |n|
      project = Project.create!(name: "Project Test #{n}", status: "Inactive", tagline: "test project", description: "this is a test project")
      users.each { |user| user.ratings.create!(project_id: project.id, code_quality: 2, 
    code_quality_just: "messy code, poorly commented", effort: 2, effort_just: "lazy",
    communication_skills: 1, communication_skills_just: "never spoke",
    general: "poor programmer, would not recommend") }
	end
  end
end