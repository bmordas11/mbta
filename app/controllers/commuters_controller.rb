class CommutersController < ApplicationController
  def index
    @all_routes = Commuter::ROUTES
  end

  def show
    @desired_route = params[:id]
    if Commuter::PROBLEM_ROUTES.include? @desired_route
      Commuter.substitue_problem_route @desired_route
    end
    @desired_route.prepend('CR-').gsub! ' Line', ''

    query = 'stopsbyroute'
    parameter = "&route=#{@desired_route}"
    the_info = Commuter.get_stop(query, parameter)
    @all_stops = []
    if the_info['direction'].present?
      the_info['direction'][0]['stop'].each do |stop|
        @all_stops << Stop.find_or_create_by(name: stop['stop_name'])
      end
    end
  end
end
