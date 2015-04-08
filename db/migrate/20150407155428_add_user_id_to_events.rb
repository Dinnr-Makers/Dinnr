class AddUserIdToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :user, index: true, foreign_key: true
  end
end
