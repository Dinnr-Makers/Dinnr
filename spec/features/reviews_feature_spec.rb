require 'rails_helper'

def leave_review(thoughts,rating)
  visit 'events'
  click_link "Makers Welcome Drinks"
  click_link "Review"
  fill_in 'Thoughts', with: thoughts
  select rating, from: "Rating"
  click_button 'Leave Review'
end

feature 'reviewing' do

  # scenario 'allows users to leave a review using a form' do
  #   party = create(:event)
  #   visit '/events'
  #   click_link "Pauls Birthday Party"
  #   click_link "Review"
  #   fill_in 'Thoughts', with: "so so"
  #   select '3', from: "Rating"
  #   click_button 'Leave Review'
  #   expect(current_path).to eq "/events/#{party.id}"
  #   expect(page).to have_content('so so')
  # end

  scenario 'allows reviews once an event has happened' do
    drinks = build(:event, title: "Makers Welcome Drinks",
            description: "Welcome drinks for the Feb Cohort",
            location: "50 Commercial Street, London, United Kingdom",
            date: '2015-02-02',
            time: '18:30:00.000',
            size: 25,
            user_id: nil,
            housenumber: "50",
            street: "Commercial Street",
            city: "London",
            country: "United Kingdom",
            postcode: "E1 6LT")
    drinks.save(validate: false)
    leave_review("so so",3)
    expect(current_path).to eq "/events/#{drinks.id}"
    expect(page).to have_content('so so')
  end

  scenario 'does not allow reviews before an event has happened' do
    party = create(:event)
    visit '/events'
    click_link "Pauls Birthday Party"
    expect(page).not_to have_link "Review"
    expect(page).to have_content "Reviews available after event"
  end

  # scenario 'only allows guests of an event to leave a review' do

  # end


end