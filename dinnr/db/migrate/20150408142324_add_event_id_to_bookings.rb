class AddEventIdToBookings < ActiveRecord::Migration
  def change
    add_reference :bookings, :event, index: true, foreign_key: true
  end
end
