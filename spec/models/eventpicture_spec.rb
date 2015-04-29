require 'spec_helper'
require 'rails_helper'

describe Eventpicture, type: :model do
  it { is_expected.to belong_to :event }
  it { is_expected.to belong_to :picture }

  it 'no longer exists when removed' do
    eventpicture = Eventpicture.new
    eventpicture.destroy
    expect(eventpicture.destroyed?).to be true
  end

end
