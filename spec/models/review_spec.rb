require 'spec_helper'

describe Review, type: :model do

  it { is_expected.to belong_to :event }
  it { is_expected.to belong_to :user }

  describe Review, :type => :model do
  it "is invalid if the rating is more than 10" do
    review = Review.new(rating: 15)
    expect(review).to have(1).error_on(:rating)
  end

end

end