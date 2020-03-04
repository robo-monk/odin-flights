class CreateFlights < ActiveRecord::Migration[6.0]
  def change
    create_table :flights do |t|
      t.datetime :datetime
      t.integer :duration
      t.integer :price

      t.timestamps
    end
  end
end
