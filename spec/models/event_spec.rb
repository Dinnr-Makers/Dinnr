require 'spec_helper'

describe Event, type: :model do

  it { is_expected.to belong_to :user }
  it { is_expected.to have_many :bookings }
  it { is_expected.to have_many :eventpictures }

  let(:kate) { double :user}
  let(:chris) {double :user}
  let(:thomas) {double :user}
  let(:sean) {double :user}

  it 'should be able to add a user to an event' do
    party = Event.new
    expect(party.guests).to eq([])
    party.add_guest(kate)
    expect(party.guests).to eq([kate])
  end

  it 'should not add a user that is already attending' do
    party = Event.new
    expect(party.guests).to eq([])
    party.add_guest(kate)
    party.add_guest(kate)
    expect(party.guests).to eq([kate])
  end

  it 'should be able to remove a user' do
    party = Event.new
    party.add_guest(kate)
    party.remove_guest(kate)
    expect(party.guests).to eq []
  end

  it 'should be able to set its size on creation' do
    options = {:size => 3}
    party = Event.new(options)
    expect(party.size).to eq 3
  end

  it 'should display a date' do
    options = {:date => Date.new(2015,04,17)}
    party = Event.new(options)
    expect(party.date_format).to eq "Fri 17 Apr"
  end

  it 'should display a time' do
    options = {:time => Time.new(2015,"apr",17,18,0,0)}
    party = Event.new(options)
    expect(party.time_format).to eq "06:00PM"
  end

  it 'will not allow an invalid date' do
    party = build(:event, date: Date.new(2010,04,17) )
    expect(party).not_to be_valid
  end

end