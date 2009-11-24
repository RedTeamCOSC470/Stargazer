##########################################################################################
# File:     image.rb
# Project:  Stargazer
# Author:   Red Team
# Desc:     The model for handling images.
##########################################################################################

class Image < ActiveRecord::Base
  belongs_to :schedule
  
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }

end
