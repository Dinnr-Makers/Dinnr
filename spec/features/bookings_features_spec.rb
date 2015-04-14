require 'rails_helper'

context 'user signed in and on the home page' do

  before do
    user_one_sign_up
  end

  it 'is able to join another users event' do
    visit '/'
    user_one_create_event
    click_link("Sign out", match: :first)
    visit '/'
    click_link('Sign up', match: :first)
    fill_in('user[first_name]', with: 'alice')
    fill_in('user[last_name]', with: 'alice surname')
    fill_in('Email', with: 'alice@example.com')
    fill_in('Password', with: 'password')
    fill_in('Password confirmation', with: 'password')
    click_button('Sign up')
    join_event
    expect(page).to have_content "Guest 1: alice"
  end

  it 'is not able to join their own event' do
    visit '/'
    user_one_create_event
    click_link "Dinner with Thomas"
    expect(page).not_to have_content "Join Event"
  end

  it 'does not let a user join an event if it is full' do
    visit '/'
    user_one_create_event
    click_link("Sign out", match: :first)
    user_two_sign_up
    join_event
    click_link("Sign out", match: :first)
    user_three_sign_up
    join_event
    click_link("Sign out", match: :first)
    user_four_sign_up
    join_event
    expect(page).to have_content "Event is full you are unable to join at the moment"
  end

end

context 'user not signed in and on an event page' do

  let!(:dinwithC){create(:event)}

  it 'does not see a join event button' do
    visit '/'
    click_link dinwithC.title
    expect(page).not_to have_link('Join Event')
  end

  it 'does not see a leave event' do
    visit '/'
    click_link dinwithC.title
    expect(page).not_to have_link('Leave Event')
  end
end

context 'user not signed in and on the home page' do
  let!(:dinwithC){create(:event)}

  it 'does not see a join event button' do
    visit '/'
    expect(page).not_to have_link('Join Event')
  end

  it 'does not see a leave event' do
    visit '/'
    expect(page).not_to have_link('Leave Event')
  end
end

context 'user signed in and on an event page' do

  before do
    user_one_sign_up
  end

  it 'does not show a join event link if the user has already signed up on the event page' do
    visit '/'
    user_one_create_event
    click_link("Sign out", match: :first)
    user_two_sign_up
    join_event
    expect(page).not_to have_link('Join Event')
  end

end