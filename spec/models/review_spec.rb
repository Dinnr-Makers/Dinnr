require 'spec_helper'

describe Review, type: :model do

  it { is_expected.to belong_to :event }
  it { is_expected.to belong_to :user }

  it "is invalid if the rating is more than 10" do
    review = Review.new(rating: 15)
    expect(review).to have(1).error_on(:rating)
  end

  it "has the reviewers name" do
    john = create(:user, id: 3, email: 'john@doe.com', password: 'testtest', password_confirmation: 'testtest', first_name: "John")
    review = Review.new(rating: 15, user: john)
    expect(review.name).to eq("John")
  end

end