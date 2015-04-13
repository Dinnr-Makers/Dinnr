class AddPictureIdToEventpictures < ActiveRecord::Migration
  def change
    add_reference :eventpictures, :picture, index: true, foreign_key: true
  end
end
