require 'rails_helper'

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
      click_link 'Add an event'
      expect(page).to have_content 'You need to sign in or sign up before continuing'
    end

  end

  context 'user signed in and on the home page' do

    before do
      visit '/'
      click_link('Sign up')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
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
      click_link 'Add an event'
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