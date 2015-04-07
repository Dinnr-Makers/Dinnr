class Event < ActiveRecord::Base
  serialize :guests,Array
end
