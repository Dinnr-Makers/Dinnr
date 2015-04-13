class Event < ActiveRecord::Base

  attr_accessor :time_format

  belongs_to :user
  has_many :bookings

  serialize :guests, Array

  geocoded_by :address
  after_validation :geocode

  def address
    [housenumber, street, city, postcode, country].compact.join(', ')
  end

  def add_guest(guest)
    unless guests.include? guest
      guests << guest
    end
  end

  def remove_guest(guest)
    guests.delete(guest)
  end

  def date_format
    self.date.strftime('%a %d %b') 
  end

  def time_format
    self.time.strftime("%I:%M%p")
  end

end
