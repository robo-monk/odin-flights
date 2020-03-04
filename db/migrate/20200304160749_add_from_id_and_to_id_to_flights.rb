class AddFromIdAndToIdToFlights < ActiveRecord::Migration[6.0]
  def change
    add_column :flights, :from_id, :integer
    add_column :flights, :to_id, :integer
  end
end
