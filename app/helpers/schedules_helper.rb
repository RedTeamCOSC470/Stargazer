module SchedulesHelper
  def get_default_date
    { :day => params[:date]['get(3i)'], :month => params[:date]['get(2i)'], 
      :year => params[:date]['get(1i)'] } rescue Date.current 
  end
  def link_to_next_day
	s = Date.parse(session[:search]) + 1
	link_to 'Next Day', schedules_path(:search => s)
  end
  def link_to_previous_day
	s = Date.parse(session[:search]) - 1
	link_to 'Previous Day', schedules_path(:search => s)
  end
  def link_to_next_week
	s = Date.parse(session[:search]) + 7 
	link_to 'Next Week', schedules_path(:search => s)
  end
  def link_to_previous_week
	s = Date.parse(session[:search]) - 7
	link_to 'Previous Week', schedules_path(:search => s)
  end
  def link_to_next_month
	s = Date.parse(session[:search]).next_month
	link_to 'Next Month', schedules_path(:search => s)
  end
  def link_to_previous_month
	s = Date.parse(session[:search]).last_month
	link_to 'Previous Month', schedules_path(:search => s)
  end
end
