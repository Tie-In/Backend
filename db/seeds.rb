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
      email: "tan@tiein.com",
      username: "Tan",
      firstname: "Tan",
      lastname: "Test",
      birth_date: "2011-11-11",
      phone_number: "12312312"
    },
    {
      email: "neen@tiein.com",
      username: "Neen",
      firstname: "Neen",
      lastname: "Test",
      birth_date: "2011-11-11",
      phone_number: "12312312"
    },
    {
      email: "mint@tiein.com",
      username: "Mint",
      firstname: "Mint",
      lastname: "Test",
      birth_date: "2011-11-11",
      phone_number: "12312312"
    },
    {
      email: "chao@tiein.com",
      username: "Chao",
      firstname: "Chao",
      lastname: "Test",
      birth_date: "2011-11-11",
      phone_number: "12312312"
    },
    {
      email: "pun@tiein.com",
      username: "PunPun",
      firstname: "PunPun",
      lastname: "Test",
      birth_date: "2011-11-11",
      phone_number: "12312312"
    },
    {
      email: "win@tiein.com",
      username: "Win",
      firstname: "Varis",
      lastname: "Test",
      birth_date: "2011-11-11",
      phone_number: "12312312"
    },
    {
      email: "max@tiein.com",
      username: "Maxmi",
      firstname: "Max",
      lastname: "Test",
      birth_date: "2011-11-11",
      phone_number: "12312312"
    }
  ])
