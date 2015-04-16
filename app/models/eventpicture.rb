class Eventpicture < ActiveRecord::Base
  belongs_to :picture
  belongs_to :event, -> { includes :picture }
end
