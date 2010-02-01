# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

# Create users
admin = User.new
admin.username = "admin"
admin.email = "test@test.com"
admin.password = "stargazer09"
admin.password_confirmation = "stargazer09"
admin.is_admin = true
admin.save
