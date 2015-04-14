require 'spec_helper'
require 'rails_helper'

describe Event, type: :model do

  it { is_expected.to belong_to :user }
  it { is_expected.to have_many :bookings }
  it { is_expected.to have_many :eventpictures }
  it { is_expected.to have_many :reviews }

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

  it 'nice_date stringifies the date nice' do
    party = create(:event)
    expect(party.nice_date).to eq "Thursday 30. April 17:20"
  end

  it 'will not allow an invalid date' do
    party = build(:event, date: Date.new(2010,04,17) )
    expect(party).not_to be_valid
  end

  it 'should know if it has happened' do
    drinks = build(:event, title: "Makers Welcome Drinks",
            description: "Welcome drinks for the Feb Cohort",
            location: "50 Commercial Street, London, United Kingdom",
            date: '2015-02-02',
            time: '18:30:00.000',
            size: 25,
            user_id: nil,
            housenumber: "50",
            street: "Commercial Street",
            city: "London",
            country: "United Kingdom",
            postcode: "E1 6LT")
    drinks.save(validate: false)
    expect(drinks.happened?).to eq true
  end

  it "saves dates like this: Fri 04 Jan 10:02 PM" do
    eventish = create(:event, date: '2020-11-11', time: '17:20:00')
    expect(eventish.date.strftime('%A %_d. %B %k:%M')).to eq("Wednesday 11. November 17:20")
  end

end

