class StopsController < ApplicationController
  def show
    @desired_stop = Stop.find(params[:id]).name
    query = 'schedulebystop'
    parameter = "&stop=#{@desired_stop}"
    the_info = Commuter.get_stop(query, parameter)
    @trains_available = the_info['mode'].present?

    @trains = []
    if @trains_available
      the_info['mode'][0]['route'].each do |route|
        trip = []
        route['direction'].each do |train_direction|
          this_train = {}
          this_train[:direction] = train_direction['direction_name']
          this_train[:departure_time] = Time.at(train_direction['trip'][0]['sch_arr_dt'].to_i)
          .strftime("%H:%M:%S %B %d %Y")
          trip << this_train
        end
        @trains << {
          route: route['route_name'],
          trip: trip
        }
      end
    end
  end

end
