class Event < ActiveRecord::Base

  attr_accessor :time_format

  belongs_to :user
  has_many :bookings
  has_many :eventpictures
  has_many :reviews
  validates :date, presence: true
  validate :future?
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
    if date.respond_to?(:strftime)
      date.strftime('%a %d %b')
    else
      date.to_s
    end
  end

  def time_format
    if time.respond_to?(:strftime)
      time.strftime("%I:%M%p")
    else
      time.to_s
    end
  end

  def future?
    if date < Date.today
      errors.add(:date, "is not valid")
    end
  end

end
