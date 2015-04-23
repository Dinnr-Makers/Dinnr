require 'spec_helper'

describe Picture, type: :model do
  it { should have_attached_file(:image) }
  it { is_expected.to belong_to :user }
  it { is_expected.to have_many :eventpictures }
end
