require_relative '../models/mbtaCommunicator.rb'
require 'pry'
require 'time'

class MBTACommunicator
  def self.get_stop(stop)
    response = HTTParty.get(
      "http://realtime.mbta.com/developer/api/v2/predictionsbystop?api_key=wX9NwuHnZU2ToO7GmGR9uw&stop=#{stop}&format=json"
    )
    binding.pry

    unless response["mode"].nil?
      @scheduled_departure_time = Time.at(
        response["mode"][0]["route"][0]["direction"][0]["trip"][0]["sch_dep_dt"]
        .to_i).strftime("%H:%M:%S %B %d %Y")
      @predicted_departure_time = Time.at(
        response["mode"][0]["route"][0]["direction"][0]["trip"][0]["pre_dt"]
        .to_i).strftime("%H:%M:%S %B %d %Y")
      puts "Scheduled departure time: #{@scheduled_departure_time}"
      puts "Predicted departure time: #{@predicted_departure_time}"
    end

    puts response
    response
  end
end

class CommutersController < ApplicationController
  def index
    # Could have this retrieve the rails that the user uses most frequently
    # And this links to the rail's show page?
    @desired_stop = "Waltham"
    @the_info = MBTACommunicator.get_stop(@desired_stop)
  end

  def show
    # Link takes you to this rail's arrival/departure info?
    @desired_stop = "Wellesley Farms"
    @the_info = MBTACommunicator.get_stop(@desired_stop)
    @trains = []

    unless response["mode"].nil?
      if @the_info[0]["trip"].nil? || @the_info[1]["trip"].nil?
        flash[:error] = "No upcoming scheduled stops at Wellesley Farms"
        render :index
      else
        @the_info.each do |train|
          Time.at(train["trip"][0]["sch_dep_dt"].to_i).strftime("%H:%M:%S %B %d %Y")
          @trains << {
            direction: train["direction_name"],
            scheduled_departure: Time.at(
              train["trip"][0]["sch_dep_dt"].to_i).strftime("%H:%M:%S %B %d %Y"),
            predicted_departure: Time.at(
              train["trip"][0]["pre_dt"].to_i).strftime("%H:%M:%S %B %d %Y")
            }
        end
      end
    end
  end

  # def new
  # end

  # def create
  # end

  # def edit
  # end

  # def update
  # end

  # def destroy
  # end

  private

  # def commuter_params
  # end
end
