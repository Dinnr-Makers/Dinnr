require 'spec_helper'

describe Eventpicture, type: :model do
  it { is_expected.to belong_to :event }
  it { is_expected.to belong_to :picture }
end
