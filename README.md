# README

This is a toy application created with Ruby on Rails following the curriculum of [The Odin Project](https://theodingproject.com). Go to [project](https://www.theodinproject.com/courses/ruby-on-rails/lessons/building-advanced-forms?ref=lnav). 
Below, I explain briefly how the app flows. You can also view it [live on Heroku](https://desolate-badlands-69332.herokuapp.com/).


*-robomonk*

***

**Database Models:**

![database diagram](https://i.imgur.com/SJjBC1m.jpg)

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

