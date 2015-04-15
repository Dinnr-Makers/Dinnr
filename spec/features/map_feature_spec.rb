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
  let!(:nice_pic){create(:picture)}
  let!(:event_pic){create(:eventpicture, event_id: event1.id, picture_id: nice_pic.id)}
   
    it "shows title and date on frontpage" do
      visit "/"
      find('#main-map-canvas')
      page.execute_script('testInfoWindow()')
      expect(page.find("div#info-box")).to have_content("Pauls Birthday Party, #{event1.nice_date}")
    end

    it "Shows a photo of the event - on single map" do
      visit "/events/#{event1.id}"
      find('#single-map-canvas')
      page.execute_script('testInfoWindow()')
      thumblink = nice_pic.image.url(:thumb).to_s
      expect(page.find("div#info-box.img")["src"]).to include?(thumblink)
    end

    xit "Shows a photo of each event - on main map" do
    end

  end
end


