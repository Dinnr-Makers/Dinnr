class AddPostcodeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :postcode, :string
  end
end
