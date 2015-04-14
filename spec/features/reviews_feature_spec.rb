require 'rails_helper'

def leave_review(thoughts,rating)
  visit 'events'
  click_link "Makers Welcome Drinks"
  click_link "Review"
  fill_in 'Thoughts', with: thoughts
  select rating, from: "Rating"
  click_button 'Leave Review'
end

def makers_drinks
  build(:event, title: "Makers Welcome Drinks",
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
        postcode: "E1 6LT",
        id: 5)
end

def john
  john = create(:user, id: 3, email: 'john@doe.com', password: 'testtest', password_confirmation: 'testtest')
end

def feedback
  create(:review, id: 7, user_id: 3, event_id: 5, thoughts: 'so so', rating: 3)
end

def ticket
  create(:booking, user_id: 3, event_id: 5)
end

feature 'reviewing' do

  scenario 'does not allow reviews before an event has happened' do
    party = create(:event)
    visit '/events'
    click_link "Pauls Birthday Party"
    expect(page).not_to have_link "Review"
    expect(page).to have_content "Reviews available after event"
  end

  scenario 'allows guests of an event to leave a review' do
    makers_drinks
    makers_drinks.save(validate: false)
    john
    ticket
    sign_in
    leave_review("so so",3)
    expect(current_path).to eq "/events/#{makers_drinks.id}"
    expect(page).to have_content('so so')
  end

  scenario 'does not let a non guest to leave a review' do
    makers_drinks
    makers_drinks.save(validate: false)
    dave = create(:user, id: 7)
    visit '/events'
    click_link "Makers Welcome Drinks"
    expect(page).not_to have_link "Review"
    expect(page).to have_content "Reviews available after event"
  end

  scenario 'user can edit their review' do
    makers_drinks
    makers_drinks.save(validate: false)
    john
    ticket
    sign_in
    feedback
    visit '/events'
    click_link "Makers Welcome Drinks"
    click_link "Edit"
    fill_in 'Thoughts', with: "great"
    click_button "Update"
    expect(current_path).to eq "/events/#{makers_drinks.id}"
    expect(page).to have_content("great")
  end

  scenario 'user cannot edit somebody elses review' do
    makers_drinks
    makers_drinks.save(validate: false)
    john
    ticket
    sign_in
    feedback
    click_link("Sign out", match: :first)
    user_one_sign_up
    visit '/events'
    click_link "Makers Welcome Drinks"
    expect(page).not_to have_link "Edit"
  end


end