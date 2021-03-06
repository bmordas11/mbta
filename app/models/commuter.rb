# frozen_string_literal: true

class Commuter < ApplicationRecord
  def self.get_stop(query, parameter)
    HTTParty.get(
      "http://realtime.mbta.com/developer/api/v2/#{query}?" +
      "api_key=#{ENV["MBTA_KEY"]}#{parameter}&format=json"
    )
  end

  def self.substitue_problem_route(route)
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
