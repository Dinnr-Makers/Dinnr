require 'rails_helper'

describe "API", :type => :request do
  before(:each) do
    event = build(:event)
    geocoded_event = create(:geocoded_event)
  end

  scenario "it serves events" do
    get "/map.json"
    json = JSON.parse(response.body)
    expect(json['features'].length).to eq(1)
  end

  scenario "it doesn't serve events that haven't been geocoded" do
    get "/map.json"
    json = JSON.parse(response.body)
    expect(json['features'].length).to eq(1)
  end
end