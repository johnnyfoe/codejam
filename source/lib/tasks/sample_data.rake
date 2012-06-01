namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(first_name: "Example",
      surname: "User",
      email: "example@railstutorial.org",
      password: "foobar",
      password_confirmation: "foobar")
    admin.toggle!(:admin)
    
    99.times do |n|
      first_name = Faker::Name.name
      second_name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!(first_name: first_name,
        surname: surname,
        email: email,
        password: password,
        password_confirmation: password)
    end
  end
end