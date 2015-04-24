class Event < ActiveRecord::Base
  attr_accessor :time_format

  belongs_to :user

  has_many :bookings, dependent: :destroy
  has_many :eventpictures, dependent: :destroy
  has_many :pictures, through: :eventpictures
  has_many :reviews, dependent: :destroy

  validates :date, presence: true
  validate :future?

  serialize :guests, Array
  before_save :compose_date
  geocoded_by :address
  after_validation :geocode

  scope :mappable_events, -> { where.not(longitude: nil) }

  acts_as_commentable

  def address
    [housenumber, street, city, postcode, country].compact.join(', ')
  end

  def add_guest(guest)
    guests << guest unless guests.include? guest
  end

  def remove_guest(guest)
    guests.delete(guest)
  end

  def nice_date
    date.respond_to?(:strftime) ? date.strftime('%A %_d %B %k:%M') : date.to_s
  end

  def future?
    errors.add(:date, 'is not valid') if date < Date.today
  end

  def happened?
    date < Date.today
  end

  def compose_date
    minutes = time.strftime('%M').to_i
    t = Time.gm(date.year, date.month, date.day, time.hour, minutes)
    self.date = t
  end

  def name
    return 'No Host' if user_id.nil?
    User.find(user_id).first_name
  end

  def photo
    return 'No Host' if user_id.nil?
    User.find(user_id).image
  end

  def avatar
    return 'No Host' if user_id.nil?
    User.find(user_id).avatar
  end
end
