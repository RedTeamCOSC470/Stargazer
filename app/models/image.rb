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
# File:     image.rb
# Project:  Stargazer
# Author:   Red Team
# Desc:     The model for handling images.
##########################################################################################

class Image < ActiveRecord::Base
  belongs_to :schedule

  # an image is associated with a file that is stored on the local disk
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }

end
