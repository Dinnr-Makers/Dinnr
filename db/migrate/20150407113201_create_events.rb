class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.string :location
      t.datetime :date
      t.integer :size
      t.text :guests

      t.timestamps null: false
    end
  end
end
