# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if Rails.env.development?

  # Create user
  User.create([
    {
      email: "test@test.com",
      username: "PP",
      firstname: "Tan",
      lastname: "Pornsriniyom",
      birth_date: "2011-11-11",
      phone_number: "12312312"
    }
  ])
