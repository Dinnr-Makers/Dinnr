require 'spec_helper'
require 'rails_helper'

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

  it 'nice_date stringifies the date nice' do
    party = create(:event)
    expect(party.nice_date).to eq "Thursday 30 April 17:20"
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

  it "saves dates like this: Fri 04 Jan 10:02 PM" do
    eventish = create(:event, date: '2020-11-11', time: '17:20:00')
    expect(eventish.date.strftime('%A %_d. %B %k:%M')).to eq("Wednesday 11. November 17:20")
  end

end

