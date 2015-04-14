class User < ActiveRecord::Base

  has_many :events
  has_many :bookings
  has_many :pictures

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.image = auth.info.image
      user.password = Devise.friendly_token[0,20]
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  has_attached_file :avatar,
                    :styles => { :normal => "50x50>", :thumb => "50x50>"  },
                    :default_url => "https://s3-us-west-2.amazonaws.com/dinnr/pictures/ChefHat.jpg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

end
