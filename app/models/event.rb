class Event < ActiveRecord::Base

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

end
