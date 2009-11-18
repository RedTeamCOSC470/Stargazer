##########################################################################################
# File:     user_test.rb
# Project:  Stargazer
# Author:   Rob
# Desc:     Unit test for the "user" model.  
##########################################################################################

# == Schema Information
#
# Table name: users
#
#  id                  :integer         not null, primary key
#  username            :string(255)     not null
#  email               :string(255)     not null
#  crypted_password    :string(255)     not null
#  password_salt       :string(255)     not null
#  persistence_token   :string(255)     not null
#  single_access_token :string(255)     not null
#  perishable_token    :string(255)     not null
#  login_count         :integer         default(0), not null
#  failed_login_count  :integer         default(0), not null
#  last_request_at     :datetime
#  current_login_at    :datetime
#  last_login_at       :datetime
#  current_login_ip    :string(255)
#  last_login_ip       :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  is_admin            :boolean
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
	
  # create a user with necessary, correct input values for the following tests
  def setup
  	@user = User.new
  	@user.username = "unit_test"
  	@user.email = "unit@test.com"
    @user.password = "test"
    @user.password_confirmation = "test"
  end
  
  def test_username_cannot_be_null
    @user.username = ""
    assert !@user.save  
  end
    
  def test_username_must_be_unique
    # create another user with same name of "unit_test"
    assert @user.save
    user2 = User.new
    user2.username = "unit_test"
  	user2.email = "unit2@test.com"
    user2.password = "test2"
    user2.password_confirmation = "test2"
    assert !user2.save
  end
  
  def test_email_cannot_be_null
    @user.email = ""
    assert !@user.save
  end

  def test_email_must_look_like_an_email_address
    # give it a non-valid looking email
    @user.email = "test.ca"
    assert !@user.save
    @user.email = "test@ca"
    assert !@user.save
    @user.email = "test@testing.testing"
    assert !@user.save
    @user.email = "@testing.testing"
    assert !@user.save
    @user.email = "test@.com"
    assert !@user.save
    
    # give it a valid looking email
    @user.email = "test@test.ca"
    assert @user.save
  end
  
  def test_password_cannot_be_null
    @user.password = ""
    @user.password_confirmation = ""
    assert !@user.save
  end
  
  def test_password_must_be_confirmed
    # do not confirm the password, should not save
    @user.password = "hithere"
    @user.password_confirmation = ""
    assert !@user.save
    
    # confirm the password, should save
    @user.password_confirmation = "hithere"
    assert @user.save
  end
  
end
