require 'rails_helper'

feature 'reviewing' do

  scenario 'allows users to leave a review using a form' do
    party = create(:event)
    visit '/events'
    click_link "Pauls Birthday Party"
    click_link "Review"
    fill_in 'Thoughts', with: "so so"
    select '3', from: "Rating"
    click_button 'Leave Review'
    expect(current_path).to eq "/events/#{party.id}"
    expect(page).to have_content('so so')
  end


end