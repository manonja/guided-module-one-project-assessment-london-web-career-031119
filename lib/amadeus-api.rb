require 'amadeus'

amadeus = Amadeus::Client.new({
  client_id: 'REPLACE_BY_YOUR_API_KEY',
  client_secret: 'REPLACE_BY_YOUR_API_SECRET'
})

begin
  puts amadeus.reference_data.urls.checkin_links.get({ airlineCode: 'BA' })
rescue Amadeus::ResponseError => error
  puts error
end


amadeus = Amadeus::Client.new(client_id: 'REPLACE_BY_YOUR_API_KEY', client_secret: 'REPLACE_BY_YOUR_API_SECRET')

amadeus = Amadeus::Client.new
