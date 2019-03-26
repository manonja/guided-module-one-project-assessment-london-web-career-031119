require 'TTY'
class CLI

  def initialize
    @prompt = TTY::Prompt.new
  end

  def get_traveller_infos
    name = @prompt.ask("Hello, bonjour, Доброе утро, what's your name?")
    @traveller = Traveller.find_or_create_by(name: name)
  end

  def welcome
    puts "Hey #{@traveller.name}, welcome to Travel Ta Life!"
  end

  def check_your_trips
    puts "Here the trips you currently have in your log: "
    # binding.pry
    # update traveler
    @traveller = Traveller.find_by(name: @traveller.name)

    if @traveller.destinations.length > 0
      @traveller.destinations.each do |destination|
      puts destination.city
      end
    else
      puts "...None for now!"
    end

  end

  def add_another_trip?
    @prompt.yes?('Want to add another trip?')
  end

  def add_destination
    puts "Enter your new trip below"
    new_trip = @prompt.collect do
      key(:city).ask('City?')
      key(:country).ask('Country?')
    end

    trip = Destination.find_or_create_by(new_trip)
    @traveller.destinations << trip
    check_your_trips

  end

  # @traveller.activities.map {|activity| activity.activity_name}



  def start
    get_traveller_infos
    welcome
    sleep(2)
    check_your_trips
    if add_another_trip?
      add_destination
    else
      "Ok, see you next time!"
    end
  end

end
