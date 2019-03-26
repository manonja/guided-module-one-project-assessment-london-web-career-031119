Activity.delete_all
Traveller.delete_all
Destination.delete_all

laura = Traveller.create(:name => "Laura", :age => 27)
mary = Traveller.create(:name => "Mary", :age => 15)
john = Traveller.create(:name => "John", :age => 45)
gul = Traveller.create(:name => "Gul", :age => 34)


montreal = Destination.create(:city => "Montreal", :country => "Canada")
moscou = Destination.create(:city => "Moscou", :country => "Russia")
cape_town = Destination.create(:city => "Cape Town", :country => "South Africa")
lima = Destination.create(:city => "Lima", :country => "Peru")
nyc = Destination.create(:city => "NYC", :country => "NY, US")

hiking = Activity.create(:activity_name => "hiking", :comment => "awesome trip", :rating => 4, :traveller_id => laura.id, :destination_id => montreal.id)
photography = Activity.create(:activity_name => "photography", :comment => "great light, great people", :rating => 4, :traveller_id => laura.id, :destination_id => moscou.id)
horse_riding = Activity.create(:activity_name => "horse_riding", :comment => "amazing nature", :rating => 3, :traveller_id => laura.id, :destination_id => cape_town.id)
surfing = Activity.create(:activity_name => "surfing", :comment => "good waves", :rating => 4, :traveller_id => laura.id, :destination_id => lima.id)
apple_picking = Activity.create(:activity_name => "apple picking", :comment => "blablabla", :rating => 3, :traveller_id => mary.id, :destination_id => nyc.id)
shopping = Activity.create(:activity_name => "shopping", :comment => "I will come back for sure", :rating => 2, :traveller_id => mary.id, :destination_id => moscou.id)
wine_tour = Activity.create(:activity_name => "wine tour", :comment => "what a food and wine scene!!", :rating => 3, :traveller_id => mary.id, :destination_id => montreal.id)
snow_shoewing = Activity.create(:activity_name => "snow shoewing", :comment => "Mindblowing nature", :rating => 5, :traveller_id => mary.id, :destination_id => lima.id)
night_photography = Activity.create(:activity_name => "night_photography", :comment => "Incredible people", :rating => 5, :traveller_id => john.id, :destination_id => cape_town.id)
fishing = Activity.create(:activity_name => "fishing", :comment => "I've seen a bear!!", :rating => 1, :traveller_id => gul.id, :destination_id => nyc.id)
kayak = Activity.create(:activity_name => " kayak", :comment => "Gimme more of kayak there", :rating => 4, :traveller_id => john.id, :destination_id => lima.id)
skiing = Activity.create(:activity_name => "skiing", :comment => "Skiing with the best instructors", :rating => 3, :traveller_id => gul.id, :destination_id => montreal.id)



#
# traveller1.activities << hiking
# dest1.activities << hiking
