class CelestialObject < ActiveRecord::Base
  has_one :schedule, :primary_key => "name", :foreign_key => "object_name"
  set_primary_key :name
end
