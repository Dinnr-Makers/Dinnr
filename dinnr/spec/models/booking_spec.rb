require 'spec_helper'

describe Booking, type: :model do

  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :event }



end