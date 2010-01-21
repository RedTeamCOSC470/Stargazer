# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

user = User.new
user.username = "admin"
user.email = "test@test.com"
user.password = "stargazer09"
user.password_confirmation = "stargazer09"
user.is_admin = true
user.save
