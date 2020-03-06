class AddFlightIdToBookings < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :flight_id, :integer
  end
end
