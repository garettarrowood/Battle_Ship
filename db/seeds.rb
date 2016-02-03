# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create! email: "submarine@guest.com", password: "battleship"
User.create! email: "destroyer@guest.com", password: "battleship"
User.create! email: "torpedo@guest.com", password: "battleship"
