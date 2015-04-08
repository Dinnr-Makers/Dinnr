class Event < ActiveRecord::Base

  belongs_to :user
  has_many :bookings

  serialize :guests,Array

  def add_guest(guest)
    unless guests.include? guest
      guests << guest
    end
  end

  def remove_guest(guest)
    guests.delete(guest)
  end

end
