require 'spec_helper'

describe Picture, type: :model do

  it { should have_attached_file(:image) }
  it { is_expected.to belong_to :user }

end