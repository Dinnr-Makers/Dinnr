require 'rails_helper'

feature 'reviewing' do
  scenario 'does not allow reviews before an event has happened' do
    party = create(:event)
    visit '/events'
    click_link 'Pauls Birthday Party'
    expect(page).not_to have_link 'Review'
  end

  scenario 'allows guests of an event to leave a review' do
    makers_drinks
    makers_drinks.save(validate: false)
    create_user_john
    ticket
    sign_in
    leave_review('so so', 3)
    expect(current_path).to eq "/events/#{makers_drinks.id}"
    expect(page).to have_content('so so')
  end

  scenario 'does not let a non guest to leave a review' do
    makers_drinks
    makers_drinks.save(validate: false)
    dave = create(:user, id: 7)
    visit '/events'
    click_link 'Makers Welcome Drinks'
    expect(page).not_to have_link 'Review'
  end

  scenario 'user can edit their review' do
    makers_drinks
    makers_drinks.save(validate: false)
    create_user_john
    ticket
    sign_in
    feedback
    visit '/events'
    click_link 'Makers Welcome Drinks'
    click_link 'Edit'
    fill_in 'Thoughts', with: 'great'
    click_button 'Update'
    expect(current_path).to eq "/events/#{makers_drinks.id}"
    expect(page).to have_content('great')
  end

  scenario 'user cannot edit somebody elses review' do
    makers_drinks
    makers_drinks.save(validate: false)
    create_user_john
    ticket
    sign_in
    feedback
    click_link('Sign out', match: :first)
    user_one_sign_up
    visit '/events'
    click_link 'Makers Welcome Drinks'
    expect(page).not_to have_link 'Edit'
  end

  scenario 'users name is added to their review' do
    makers_drinks
    makers_drinks.save(validate: false)
    create_user_john
    ticket
    sign_in
    leave_review('so so', 3)
    expect(page).to have_content('John:')
  end
end
