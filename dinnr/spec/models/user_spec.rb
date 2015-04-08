require 'spec_helper'

describe User, type: :model do

  it { is_expected.to have_many :events }
  it { is_expected.to have_many :bookings }

end