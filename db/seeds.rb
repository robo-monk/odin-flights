# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Airport.create(name:'Athens International Airport', code:'ATH', location: 'Athens, Greece')
Airport.create(name:'Amsterdam Airport Schiphol', code:'AMS', location: 'Amsterdam, Netherlands')
Airport.create(name:'John F. Kennedy International Airport', code:'JFK', location: 'New York, United States')
Airport.create(name:'Beijing Daxing International Airport', code:'PEK', location: 'Beijing, China')
Airport.create(name:'Paris-Charles De Gaulle', code:'CDG', location: 'Paris, France')
Airport.create(name:'London Heathrow', code:'LHR', location: 'London, United Kingdom')
Airport.create(name:'Frankfurt Airport', code:'FRA', location: 'Frankfurt, Switzerland')
Airport.create(name:'Rome Leonardo da Vinci-Fiumicino Airport ', code:'FCO', location: 'Rome, Italy')
Airport.create(name:'King Fahd International Airport ', code:'DMM', location: 'Qatif, Saudi Arabia')



420.times do
  airports = Airport.order(Arel.sql('RANDOM()'))
  f = Flight.new
  f.from = airports[0]
  f.to = airports[1]
  f.duration = rand(1.5..8.0)
  f.price = rand(70..500)
  from = Time.now
  to = Time.now + 1.year
  f.datetime = Time.at(from + rand * (to.to_f - from.to_f))
  f.save
end
