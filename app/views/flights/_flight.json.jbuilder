json.extract! flight, :id, :datetime, :from, :to, :duration, :price, :created_at, :updated_at
json.url flight_url(flight, format: :json)
