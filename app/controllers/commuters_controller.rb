require 'pry'
require 'time'

class MBTACommunicator
  def self.get_stop(stop)
    response = HTTParty.get(
      "http://realtime.mbta.com/developer/api/v2/predictionsbystop?" +
        "api_key=wX9NwuHnZU2ToO7GmGR9uw&stop=#{stop}&format=json"
    )
  end
end

class CommutersController < ApplicationController
  def index
  end

  def show
    @desired_stop = "Wellesley Farms"
    @the_info = MBTACommunicator.get_stop(@desired_stop)
    @inbound_scheduled_arrival = Time.at(@the_info['mode'][0]['route'][0]['direction'][0]['trip'][0]['sch_arr_dt'].to_i).strftime("%H:%M:%S %B %d %Y")
    @outbound_scheduled_departure = "Outbound Info soon to come"
  end

end
