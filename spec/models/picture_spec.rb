require 'spec_helper'

describe Picture do

  it { should have_attached_file(:image) }

end