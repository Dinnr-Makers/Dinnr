require "rails_helper"

describe "Map", js: true do

  let!(:event1){create(:event)}
  let!(:event2){create(:event)}

  it "shows a marker for a geocoded event on front page" do  
    visit '/'
    find('#main-map-canvas')
    page.execute_script('testInfo()')
    expect(page.find("div#info-box").text).to eq(event1.title)
  end

  it "shows a marker for each geocoded event on front page" do  
    visit '/'
    find('#main-map-canvas')
    page.execute_script('testInfoCount()')
    expect(page.find("div#info-box").text).to eq("2")
  end


  it "shows a marker for an event on event's page" do
    visit "/events/#{event1.id}"
    expect(page).to have_css("#single-map-canvas")
    page.execute_script('testInfo()')
    expect(page.find("div#info-box").text).to eq(event1.title)
  end

  context "Tooltips" do
  let!(:event1){create(:event)}
  let!(:event2){create(:event)}
   
    it "shows title and date on frontpage" do
      visit "/"
      find('#main-map-canvas')
      page.execute_script('testInfoWindow()')
      expect(page.find("div#info-box")).to have_content("Pauls Birthday Party 2020-04-30T17:20:00.000Z")
    end
  end
end