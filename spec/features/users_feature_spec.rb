require 'rails_helper'

def user_one_sign_up
  visit '/'
  click_link('Sign up', match: :first)
  fill_in('First name', with: 'firstname')
  fill_in('Last name', with: 'lastname')
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

feature 'users' do
  context 'user not signed in and on the home page' do

    it 'should see a sign in and sign up link' do
      visit '/'
      expect(page).to have_content("Sign in")
      expect(page).to have_content("Sign up")
    end

    it 'should not see a sign out link' do
      visit '/'
      expect(page).not_to have_link('Sign out')
    end

    it 'should not be able to create a new event' do
      visit '/'
      click_link('Create event', match: :first)
      expect(page).to have_content 'You need to sign in or sign up before continuing'
    end

  end

  context 'user signed in and on the home page' do

    before do
      user_one_sign_up
    end

    it 'should see a sign out link' do
      visit '/'
      expect(page).to have_link('Sign out')
    end

    it 'should not have a sign in or or sign up link' do
      visit '/'
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end

    it 'should be able to create a new event' do
      visit '/'
      click_link('Create event', match: :first)
      fill_in 'Title', with: 'Dinner with Thomas'
      fill_in 'Description', with: "Dinner at Thomas' house"
      fill_in 'Location', with: 'E1 1EJ'
      fill_in 'Date', with: 'Tuesday 7.30pm'
      fill_in 'Size', with: '3'
      click_button 'Create Event'
      expect(page).to have_content 'Dinner with Thomas'
      expect(current_path).to eq '/events'
    end

  end

end

feature 'users profile page' do

  context 'no users signed up' do
    it 'should display no users yet' do
      visit '/users'
      expect(page).to have_content 'No users yet'
    end

  end

  context 'user signed in and on profile page' do
    it 'should display the user details' do
      user_one_sign_up
      visit '/users'
      expect(page).to have_content 'test@example.com'
      expect(page).to have_content 'firstname'
    end

    it 'should display the user\'s last name' do
      user_one_sign_up
      visit '/users'
      expect(page).to have_content 'lastname'
    end

    xit 'should display the uploaded image' do

    end

  end



end