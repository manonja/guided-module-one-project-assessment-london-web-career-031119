Activity.delete_all
Traveller.delete_all
Destination.delete_all

traveller1 = Traveller.create(:name => "Laura", :age => 27)
traveller2 = Traveller.create(:name => "Mary", :age => 15)
traveller3 = Traveller.create(:name => "John", :age => 45)
traveller4 = Traveller.create(:name => "Gul", :age => 34)

dest1 = Destination.create(:city => "Montreal", :country => "Canada")
dest2 = Destination.create(:city => "Moscou", :country => "Russia")
dest3 = Destination.create(:city => "Cape Town", :country => "South Africa")
dest4 = Destination.create(:city => "Lima", :country => "Peru")

hiking = Activity.create(:activity_name => "hiking", :comment => "awesome trip", :rating => 4)

traveller1.activities << hiking
dest1.activities << hiking
