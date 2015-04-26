class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  validates :rating, inclusion: (1..10)
  attr_accessor :name

  def name
    User.find(user_id).first_name
  end
end
