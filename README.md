# README

This is a toy application created with Ruby on Rails following the curriculum of [The Odin Project](https://theodingproject.com). Go to [project](https://www.theodinproject.com/courses/ruby-on-rails/lessons/building-advanced-forms?ref=lnav). 
Below, I explain briefly how the app flows, but keep in mind the 'Documentation' is terrible, as I didn't want to spend too much time on it. Maybe I'll improve it in the future. You can also view the app [live on Heroku](https://infinite-ridge-41115.herokuapp.com/).


*-robomonk*

***

**Database Models:**

![database diagram](https://i.imgur.com/SJjBC1m.jpg)

**Seeding the Database:**

Unfortunately I had to hardcode the seeds for the Airports, but creating flights was simple.

```Ruby
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
```

**Searching flights**

Below you can see my code, but avoid using something similar. When searching over the SQL database with an variable interpolated string, it's possible for a malicious user to use a SQL injection attack and access your whole database. This is a toy app, so I did't really bother with it as it was easier and faster to code. Notice the `.html_safe` method called on the `@searching_for`, it tells rails to handle this string as pure html and render it with the styling I want. Again avoid this, as you want to isolate the html generation only in the View part of the MVC structure. 

```Ruby
def find_flights(params)
  params[:from].nil? || params[:from].empty? ? from = 'from_id' : from = params[:from]
  params[:to].nil? || params[:to].empty? ? to = 'to_id' : to = params[:to]
  from_text = Airport.exists?(id: params[:from]) ? Airport.find(params[:from]).code : 'ANYWHERE'
  to_text = Airport.exists?(id: params[:from]) ? Airport.find(params[:from]).code : 'ANYWHERE'
  @searching_for = "<h2> Searching for: </h2> Flights from  <strong> #{from_text} </strong>  to <strong> #{to_text} </strong".html_safe
  @flights = Flight.where("from_id = #{from} AND to_id = #{to}").order(:datetime)
end
```

**Bookings**

A problem that I faced with this project, is that a `Passenger` object had to be created in a form used to create a new `Booking`. I used `accepts_nested_attributes_for :passengers` in the `Booking` model so params for a `Passenger` object could be accepted through the `Booking` form.


