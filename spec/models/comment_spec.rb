require 'spec_helper'
require 'rails_helper'

describe Comment, type: :model do

  it 'displays a date in a nice clean format' do
    john = create(:user, id: 3, email: 'john@doe.com', password: 'testtest', password_confirmation: 'testtest')
    remark = create(:comment, user: john, created_at: "2015-04-14 17:39:46")
    expect(remark.nice_date).to eq "Tuesday 14 April 2015 17:39"
  end

end