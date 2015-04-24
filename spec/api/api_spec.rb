require 'rails_helper'

describe 'API', :type => :request do
  let!(:geocoded_event) { create(:event) }
  let!(:nice_pic) { create(:picture) }
  let!(:event_pic) { create(:eventpicture, event_id: geocoded_event.id, picture_id: nice_pic.id) }
  let!(:geocoded_event2) { create(:event) }
  let!(:nice_pic2) { create(:picture) }
  let!(:event_pic2) { create(:eventpicture, event_id: geocoded_event2.id, picture_id: nice_pic2.id) }

  scenario 'it serves events' do
    get '/api/v1/events/map'
    json = JSON.parse(response.body)
    expect(json['features'].length).to eq(2)
  end

  scenario "it doesn't serve events that haven't been geocoded" do
    event_without_geocode = create(:event, housenumber: '55', street: 'Nilstreet', city: 'Niltown', postcode: 'nil', country: 'NilCountry')
    get '/api/v1/events/map'
    json = JSON.parse(response.body)
    expect(json['features'].length).to eq(2)
  end

  scenario 'it returns data for single events on map/:id' do
    get "/api/v1/events/#{geocoded_event.id}/map"
    assert response.body.include?(geocoded_event.title)
  end

  scenario 'it serves a link to thumb, medium and original if the event has a photo' do
    get "/api/v1/events/#{geocoded_event.id}/map"
    assert response.body.include?('mediumURL')
    assert response.body.include?('originalURL')
    assert response.body.include?(nice_pic.image.url(:thumb))
  end

  scenario 'it serves imagelinks in each event in api/v1/events/map' do
    get '/api/v1/events/map'
    assert response.body.include?('mediumURL')
    assert response.body.include?('originalURL')
    assert response.body.include?(nice_pic.image.url(:thumb))
  end
end
