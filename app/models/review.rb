class Review < ActiveRecord::Base

  belongs_to :event
  validates :rating, inclusion: (1..10)

end
