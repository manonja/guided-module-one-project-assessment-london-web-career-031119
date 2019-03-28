require 'pry'
require 'json'
require 'rest-client'


class Trip < ActiveRecord::Base
  has_many :activities
  has_many :travellers, through: :activities

  # Checks if the user enters a city and a country
  validates :city, presence: true
  validates :country, presence: true

  def self.trips
    Trip.all.map {|trip| trip.city}.uniq
  end

  def self.all_cities
    self.all.map {|trip| trip.city }
  end

  def self.get_country_data(name)
    url = "https://restcountries.eu/rest/v2/name/#{name}"
    response = RestClient.get(url)
    # get an array of hashes
     data = JSON.parse(response)
     data_hash = data[0]
     # get the country name
     country = data_hash["name"]
     capital = data_hash["capital"]
     population = data_hash["population"]
     languages = []
     data_hash["languages"][0].each {|key, value| languages << value}
     # binding.pry
     puts "Country: #{country}  |  Capital: #{capital}  |  Population: #{population}  |  Languages spoken in this country: #{languages.join(", ")}."

  end




end
