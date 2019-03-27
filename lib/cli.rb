require 'TTY'

class CLI

  def initialize
    @prompt = TTY::Prompt.new(active_color: :cyan)
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
    trip
  end

  def add_activity

    puts "Enter your activity below"
    new_activity = {}

    new_activity[:activity_name] = @prompt.ask('Activity?')
    new_activity[:comment] = @prompt.ask('Comment?')
    new_activity[:traveller] = @traveller

    if @traveller.destinations.length > 0
      destination_name = @prompt.select('Destination?', @traveller.get_cities)
      new_activity[:destination] = Destination.find_by(city: destination_name)
    else
      new_activity[:destination] = add_destination
    end

    activity = @traveller.add_new_activity(new_activity)
  end

  def edit_comment_on_activity?
    @prompt.yes?('Want to edit a post on one of your activity?')
  end

  def edit_comment_on_activity
    @traveller = Traveller.find_by(name: @traveller.name)

    choices = @traveller.get_activities

    select_activity = @prompt.select("Choose your destiny and edit me...", choices)

    activity = Activity.find_by(activity_name: select_activity)

    # put in the console the current comment
    puts "#{activity.comment}"
    new_comment = @prompt.ask("Change this comment below!")
    # set the new comment to the user input
    activity.comment = new_comment
    # save it to the database
    activity.save

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
      puts "Ok then...!"
    end

    if edit_comment_on_activity?
      edit_comment_on_activity
    else
      puts "Ok, see ya!"
    end

  end
end
