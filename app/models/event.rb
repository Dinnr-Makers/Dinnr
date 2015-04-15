class Event < ActiveRecord::Base

  attr_accessor :time_format

  belongs_to :user
  has_many :bookings
  has_many :eventpictures
  has_many :reviews
  validates :date, presence: true
  validate :future?
  serialize :guests, Array
  before_save :compose_date
  geocoded_by :address
  after_validation :geocode

  acts_as_commentable

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

  def nice_date
    if date.respond_to?(:strftime)
      date.strftime('%A %_d. %B %k:%M')
    else
      date.to_s
    end
  end


  def future?
    if date < Date.today
      errors.add(:date, "is not valid")
    end
  end

  def happened?
    date < Date.today
  end

  def compose_date
    minutes = time.strftime("%M").to_i
    t = Time.gm(date.year, date.month, date.day, time.hour, minutes)
    self.date = t
  end

end
