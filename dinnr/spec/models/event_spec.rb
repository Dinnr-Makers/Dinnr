require 'spec_helper'

describe Event, type: :model do

  it { is_expected.to belong_to :user }

  let(:kate) { double :user}

  it 'should be able to add a user to an event' do
    party = Event.new
    expect(party.guests).to eq([])
    party.add_guest(kate)
    expect(party.guests).to eq([kate])
  end

  it 'should not add a user that is already attending' do
    party = Event.new
    party.add_guest(kate)
    party.add_guest(kate)
    expect(party.guests).to eq([kate])
  end

end