require 'TTY'
class CLI

  def initialize
    @prompt = TTY::Prompt.new
  end

  def get_traveller_name
    name = @prompt.ask("Hello, bonjour, Доброе утро, what's your name?")
    @traveller = Traveller.find_or_create_by(name: name)
  end

  def welcome
    puts "Hey #{@traveller.name}, welcome to Travel Ta Life!"
  end

  def check_your_trips
    puts "Here the trips you currently have in your log: "
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

  def check_activities
    puts "Here the activities you've done in your previous trips: "
    @traveller = Traveller.find_by(name: @traveller.name)

    if @traveller.activities.length > 0
      @traveller.activities.each do |activity|
        puts activity.activity_name
      end
    else
      puts "No activity in your log yet!"
    end
  end

  def add_another_trip?
    @prompt.yes?('Want to add another trip?')
  end

  def add_a_new_activity?
    @prompt.yes?('Want to add another activity?')
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

  def add_activity
    puts "Enter your activity below"
    new_activity = @prompt.collect do
      key(:activity_name).ask('Activity?')
      key(:comment).ask('Comment?')
      key(:rating).ask('Rating?', convert: :int)
      key(:destination_id).ask('Destination?', convert: :int)
    end

    activity = Activity.find_or_create_by(new_activity)
    @traveller.activities << activity
    check_activities

  end

  def delete_destination?
    @prompt.yes?('Do you want to remove a destination from your log?')

  end

  def delete_destination
    @traveller = Traveller.find_by(name: @traveller.name)
    choices = @traveller.get_destinations
    to_delete = @prompt.select("Choose your destiny and remove me...", choices)
    # destroy the relationship between traveller and destination
    @city = Destination.find_by(city: to_delete)
    @city.destroy
  end

  def start
    get_traveller_name
    welcome

    sleep(1)

    check_your_trips
    if add_another_trip?
      add_destination
    else
      puts "Ok, let's move on"
    end

    if delete_destination?
      delete_destination
    else
      puts "Ok, let's move on"
    end

    sleep(1)

    check_activities
    if add_a_new_activity?
      add_activity
    else
      puts "Ok see ya!"
    end
  end

end
