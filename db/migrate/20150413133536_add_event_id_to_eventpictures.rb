class AddEventIdToEventpictures < ActiveRecord::Migration
  def change
    add_reference :eventpictures, :event, index: true, foreign_key: true
  end
end
