require 'rails_helper'

def user_one_sign_up
  visit '/'
  click_link('Sign up', match: :first)
  fill_in('Email', with: 'test@example.com')
  fill_in('Password', with: 'testtest')
  fill_in('Password confirmation', with: 'testtest')
  click_button('Sign up')
end

def user_two_sign_up
  visit '/'
  click_link('Sign up', match: :first)
  fill_in('Email', with: 'alice@example.com')
  fill_in('Password', with: 'password')
  fill_in('Password confirmation', with: 'password')
  click_button('Sign up')
end

def user_one_create_event
  visit '/events'
  click_link('Create event', match: :first)
  fill_in 'Title', with: 'Dinner with Thomas'
  fill_in 'Description', with: "Dinner at Thomas' house"
  fill_in 'Location', with: 'E1 1EJ'
  fill_in 'Date', with: 'Tuesday 7.30pm'
  fill_in 'Size', with: '3'
  click_button 'Create Event'
end

context 'user signed in and on the home page' do

  before do
    user_one_sign_up
  end

  it 'should be able to join another users event' do
    visit '/'
    user_one_create_event
    click_link("Sign out", match: :first)
    user_two_sign_up
    click_link "Dinner with Thomas"
    click_link "Join Event"
    expect(page).to have_content "Guest 1: alice@example.com"
  end

  it 'should be able to leave an event that they have joined' do
    visit '/'
    user_one_create_event
    click_link("Sign out", match: :first)
    user_two_sign_up
    click_link "Dinner with Thomas"
    click_link "Join Event"
    expect(page).to have_content "Guest 1: alice@example.com"
    click_link "Leave Event"
    expect(page).not_to have_content "Guest 1: alice@example.com"
  end

  it 'should not be able to join an event they have already joined' do
    visit '/'
    user_one_create_event
    click_link("Sign out", match: :first)
    user_two_sign_up
    click_link "Dinner with Thomas"
    click_link "Join Event"
    expect(page).to have_content "Guest 1: alice@example.com"
    click_link "Join Event"
    expect(page).to have_content "You have already joined this event"
  end

  it 'should not be able to leave event that they have not already joined' do
    visit '/'
    user_one_create_event
    click_link("Sign out", match: :first)
    user_two_sign_up
    click_link "Dinner with Thomas"
    click_link "Leave Event"
    expect(page).to have_content "You have not joined this event yet"
  end

  it 'should not be able to join their own event' do
    visit '/'
    user_one_create_event
    click_link "Dinner with Thomas"
    click_link "Join Event"
    expect(page).to have_content "You cannot join your own event"
  end












end