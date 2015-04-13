require 'spec_helper'

describe User, type: :model do

  it { is_expected.to have_many :events }
  it { is_expected.to have_many :bookings }
  it { should have_attached_file :avatar }
  it { is_expected.to have_many :pictures }

end