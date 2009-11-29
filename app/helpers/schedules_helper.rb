module SchedulesHelper
  def get_default_date
    { :day => params[:date]['get(3i)'], :month => params[:date]['get(2i)'], 
      :year => params[:date]['get(1i)'] } rescue Date.current 
  end
end
