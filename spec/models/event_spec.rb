require 'spec_helper'

describe Event, type: :model do

  it { is_expected.to belong_to :user }
  it { is_expected.to have_many :bookings }
  it { is_expected.to have_many :eventpictures }
  it { is_expected.to have_many :reviews }

  let(:kate) {double :user}
  let(:chris) {double :user}
  let(:thomas) {double :user}
  let(:sean) {double :user}
  let(:party) {Event.new}
  let(:add_guest) {party.add_guest(kate)}

  it 'is able to add a user to an event' do
    expect(party.guests).to eq([])
    add_guest
    expect(party.guests).to eq([kate])
  end

  it 'does not add a user that is already attending' do
    expect(party.guests).to eq([])
    2.times {add_guest}
    expect(party.guests).to eq([kate])
  end

  it 'is able to remove a user' do
    add_guest
    party.remove_guest(kate)
    expect(party.guests).to eq []
  end

  it 'is able to set its size on creation' do
    options = {:size => 3}
    party = Event.new(options)
    expect(party.size).to eq 3
  end

  it 'displays a date' do
    options = {:date => Date.new(2015,04,17)}
    party = Event.new(options)
    expect(party.date_format).to eq "Fri 17 Apr"
  end

  it 'displays a time' do
    options = {:time => Time.new(2015,"apr",17,18,0,0)}
    party = Event.new(options)
    expect(party.time_format).to eq "06:00PM"
  end

  it 'will not allow an invalid date' do
    party = build(:event, date: Date.new(2010,04,17) )
    expect(party).not_to be_valid
  end

  it 'knows if an event has happened' do
    makers_drinks
    makers_drinks.save(validate: false)
    expect(makers_drinks.happened?).to eq true
  end
end