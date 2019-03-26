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
    @traveller.destinations.each do |destination|
    puts destination.city
    end
  end

  # def show_my_activities
  # => @traveller.activities.map {|activity| activity.activity_name}
  # end


  def start
    get_traveller_infos
    welcome
    check_your_trips
  end

end
