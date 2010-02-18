class CelestialObjectsController < ApplicationController

  def index
    @celestial_objects = CelestialObject.find(:all,
                                              :conditions => ['UPPER(name) LIKE UPPER(?)', "%#{params[:search]}%"],
                                              :limit => 10,
                                              :order => 'name ASC')

    respond_to do |format|
      format.js
    end
  end

end
