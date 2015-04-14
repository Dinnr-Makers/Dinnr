require "rails_helper"

describe "Map", js: true do

  let!(:event1){create(:event)}

  it "shows a marker for each geocoded event" do  
    visit '/'
    find('#map-canvas')
    page.execute_script('checkInfo()')
    expect(page.find("div#info-box").text).to eq(event1.title)
  end
end



# map.data.getFeatureById(1).getProperty("title")
# expect(find('#map-canvas')['data-markers'].split('},{').count).to eq(1)
# idee = page.execute_script('map.data.getFeatureById(1).getProperty("title")')
# find('.login-control').first
# find('#map-canvas')