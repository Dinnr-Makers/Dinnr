class Event < ActiveRecord::Base

  belongs_to :user

  serialize :guests,Array
end
