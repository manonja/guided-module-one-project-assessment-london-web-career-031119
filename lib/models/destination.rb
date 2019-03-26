class Destination < ActiveRecord::Base
  has_many :activities
  has_many :travellers, through: :activities

  # Checks if the user enters a city and a country
  validates :city, presence: true
  validates :country, presence: true

  




end
