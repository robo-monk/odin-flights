class Flight < ApplicationRecord
  belongs_to :from, class_name: "Airport"
  belongs_to :to, class_name: "Airport"
  has_many :bookings
end
