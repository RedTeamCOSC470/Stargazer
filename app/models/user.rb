# == Schema Information
#
# Table name: users
#
#  id                  :integer(38)     not null, primary key
#  username            :string(255)     not null
#  email               :string(255)     not null
#  crypted_password    :string(255)     not null
#  password_salt       :string(255)     not null
#  persistence_token   :string(255)     not null
#  single_access_token :string(255)     not null
#  perishable_token    :string(255)     not null
#  login_count         :integer(38)     default(0), not null
#  failed_login_count  :integer(38)     default(0), not null
#  last_request_at     :datetime
#  current_login_at    :datetime
#  last_login_at       :datetime
#  current_login_ip    :string(255)
#  last_login_ip       :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  is_admin            :boolean(1)
#

##########################################################################################
# File:     user.rb
# Project:  Stargazer
# Author:   Red Team
# Desc:     The "user" model. Uses "authlogic" plugin for authentication.
# =>        Added authorization with the "is_admin" boolean column.
# =>        A "user" may have many "schedules".
##########################################################################################

class User < ActiveRecord::Base  
  has_many :schedules
  
  # method of Authlogic; signifies that this user model is used for authentication
  acts_as_authentic
  
end  
