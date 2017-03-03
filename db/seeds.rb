# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if Rails.env.development?

  # Create user
  User.create!([
    {
      email: "tan@tiein.com",
      username: "Tan",
      firstname: "Tan",
      lastname: "Test",
      password: "12341234",
      birth_date: "11/11/2011",
      phone_number: "12312312"
    },
    {
      email: "neen@tiein.com",
      username: "Neen",
      password: "12341234",
      firstname: "Neen",
      lastname: "Test",
      birth_date: "11/11/2011",
      phone_number: "12312312"
    },
    {
      email: "mint@tiein.com",
      username: "Mint",
      password: "12341234",
      firstname: "Mint",
      lastname: "Test",
      birth_date: "11/11/2011",
      phone_number: "12312312"
    },
    {
      email: "chao@tiein.com",
      username: "Chao",
      password: "12341234",
      firstname: "Chao",
      lastname: "Test",
      birth_date: "11/11/2011",
      phone_number: "12312312"
    },
    {
      email: "pun@tiein.com",
      username: "PunPun",
      password: "12341234",
      firstname: "PunPun",
      lastname: "Test",
      birth_date: "11/11/2011",
      phone_number: "12312312"
    },
    {
      email: "win@tiein.com",
      username: "Win",
      password: "12341234",
      firstname: "Varis",
      lastname: "Test",
      birth_date: "11/11/2011",
      phone_number: "12312312"
    },
    {
      email: "max@tiein.com",
      username: "Maxmi",
      password: "12341234",
      firstname: "Max",
      lastname: "Test",
      birth_date: "11/11/2011",
      phone_number: "12312312"
    }
  ])
end
