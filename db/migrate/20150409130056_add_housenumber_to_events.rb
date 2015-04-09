class AddHousenumberToEvents < ActiveRecord::Migration
  def change
    add_column :events, :housenumber, :string
  end
end
