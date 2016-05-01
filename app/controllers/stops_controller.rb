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

class StopsController < ApplicationController

  def show
    @desired_stop = Stop.find(params[:id]).name
    query = 'predictionsbystop'
    parameter = "&stop=#{@desired_stop}"
    the_info = MBTACommunicator.get_stop(query, parameter)

    if !the_info['mode'].nil?
      @trip = the_info['mode'][0]['route'][0]['direction'][0]
      @inbound_scheduled_arrival = Time.at(
        @trip['trip'][0]['sch_arr_dt'].to_i
        ).strftime("%H:%M:%S %B %d %Y")
      @scheduled_departure = Time.at(
        @trip['trip'][0]['sch_dep_dt'].to_i
        ).strftime("%H:%M:%S %B %d %Y")
      @direction = @trip['direction_name']
    else
      @inbound_scheduled_arrival = '(No impending arrivals scheduled)'
      @scheduled_departure = '(No impending departures scheduled)'
    end
  end
end
