class Picture < ActiveRecord::Base
  belongs_to :user
  has_many :eventpictures
  has_many :events, through: :eventpictures

  has_attached_file :image, :styles => { :medium => '300x300>', :thumb => '100x100>' }, :default_url => 'https://s3-us-west-2.amazonaws.com/dinnr/pictures/chefhatsmall.jpg'
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

end
