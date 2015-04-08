class Event < ActiveRecord::Base

  belongs_to :user

  serialize :guests,Array

def add_guest(guest)
  unless guests.include? guest
    guests << guest
  end
end

end
