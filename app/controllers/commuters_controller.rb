require 'pry'
require 'time'

class MBTACommunicator
  def self.get_stop(query, parameter)
    HTTParty.get(
      "http://realtime.mbta.com/developer/api/v2/#{query}?" +
      "api_key=wX9NwuHnZU2ToO7GmGR9uw#{parameter}&format=json"
    )
  end
end

class CommutersController < ApplicationController
  def index
    @all_routes = ROUTES
  end

  def show
    @desired_route = params[:id]
    if PROBLEM_ROUTES.include? @desired_route
      substitue_problem_route @desired_route
    end
    @desired_route.prepend('CR-').gsub! ' Line', ''

    query = 'stopsbyroute'
    parameter = "&route=#{@desired_route}"
    the_info = MBTACommunicator.get_stop(query, parameter)
    @all_stops = []
    the_info['direction'][0]['stop'].each do |stop|
      @all_stops << Stop.find_or_create_by(name: stop['stop_name'])
    end
    @inbound_scheduled_arrival = 'Under construction'
    @outbound_scheduled_departure = 'Outbound info soon to come'
  end

  def substitue_problem_route(route)
    route.gsub!('Framingham/', '')
    route.gsub!('Kingston/', '')
    route.gsub!('Middleborough/', '')
    route.gsub!('Newburyport/', '')
    route.gsub!('Providence/', '')
  end

  PROBLEM_ROUTES = [
    'Framingham/Worcester Line',
    'Kingston/Plymouth Line',
    'Middleborough/Lakeville Line',
    'Newburyport/Rockport Line',
    'Providence/Stoughton Line'
  ].freeze

  ROUTES = [
    "Fairmount Line",
    "Fitchburg Line",
    "Framingham/Worcester Line",
    "Franklin Line",
    "Greenbush Line",
    "Haverhill Line",
    "Kingston/Plymouth Line",
    "Lowell Line",
    "Middleborough/Lakeville Line",
    "Needham Line",
    "Newburyport/Rockport Line",
    "Providence/Stoughton Line"
  ].freeze

end
