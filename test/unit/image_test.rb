# == Schema Information
#
# Table name: images
#
#  id                 :integer(38)     not null, primary key
#  schedule_id        :integer(38)
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer(38)
#  image_updated_at   :datetime
#  created_at         :datetime
#  updated_at         :datetime
#

##########################################################################################
# File:     image_test.rb
# Project:  Stargazer
# Author:   Red Team
# Desc:     Unit test for the "Image" model.  
##########################################################################################

require 'test_helper'

class ImageTest < ActiveSupport::TestCase
 
end
