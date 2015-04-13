require "rails_helper"

describe "Map", js: true do

  it "shows a marker for each geocoded event" do
    create(:event)
    visit '/'
    expect(find('#map-canvas')['data-markers'].split('},{').count).to eq(1)
  end
end