# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.new
user.email = 'admin@productms.com'
user.password = 'Password123!@#'
user.first_name = 'hariss'
user.last_name = 'mansoor'
user.username= 'hariss123'
user.save!