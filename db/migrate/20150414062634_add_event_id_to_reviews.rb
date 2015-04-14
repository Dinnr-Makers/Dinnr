class AddEventIdToReviews < ActiveRecord::Migration
  def change
    add_reference :reviews, :event, index: true, foreign_key: true
  end
end
