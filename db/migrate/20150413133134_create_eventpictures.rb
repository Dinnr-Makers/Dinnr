class CreateEventpictures < ActiveRecord::Migration
  def change
    create_table :eventpictures do |t|

      t.timestamps null: false
    end
  end
end
