require 'rails_helper'

def user_sign_up

  visit '/'
  click_link('Sign up', match: :first)
  fill_in('Email', with: 'test@example.com')
  fill_in('Password', with: 'testtest')
  fill_in('Password confirmation', with: 'testtest')
  click_button('Sign up')

end

def create_event
  visit '/events'
  click_link('Create event', match: :first)
  fill_in 'Title', with: 'Dinner with Thomas'
  fill_in 'Description', with: "Dinner at Thomas' house"
  fill_in 'autocomplete', with: 'E1 1EJ'
  fill_in 'Date', with: 'Tuesday 7.30pm'
  fill_in 'Size', with: '3'
  click_button 'Create Event'
end

feature 'events' do
  context 'no events have been added' do
    scenario 'should display a prompt to add an event' do
      visit '/events'
      expect(page).to have_content 'No events yet'
      expect(page).to have_link 'Create event'
    end
  end

  context 'events have been added' do

    before do
      Event.create(title: 'Dinner with Thomas', location: 'E1 1EJ', date: 'Tuesday 7.30pm' )
    end

    scenario 'display events' do
      visit '/events'
      expect(page).to have_content 'Dinner with Thomas'
    end
  end

  context 'adding an event' do

    scenario 'prompts a user to fill out a from and then displays the new event' do
      user_sign_up
      create_event
      expect(page).to have_content 'Dinner with Thomas'
      expect(current_path).to eq '/events'
    end
  end

  context 'viewing an event' do

    let!(:dinwitht){Event.create(title: 'Dinner with Thomas', description: "Dinner at Thomas' house", location: 'E1 1EJ', date: 'Tuesday 7.30pm', size: '3')}

    scenario 'lets a user view an event' do
      visit '/events'
      click_link ('Dinner with Thomas')
      expect(page).to have_content "Dinner at Thomas' house"
      expect(current_path).to eq "/events/#{dinwitht.id}"
    end

    scenario 'should show that there are no guests when created' do
      visit '/events'
      click_link ('Dinner with Thomas')
      expect(page).to have_content "No guests yet"
    end
  end

  context 'editing an event' do

    let!(:dinwithC){Event.create(title: 'Dinner with Chris', description: "Dinner at Chris' house", location: 'BN3 6FU', date: 'Wednesday 7.30pm', size: '3')}

    scenario 'does not let a user edit an event that they have not created' do
      user_sign_up
      visit '/'
      click_link 'Edit Dinner with Chris'
      expect(page).to have_content 'You can only edit events that you have created'
      expect(current_path).to eq('/events')
    end

    scenario 'does let a user edit an event they have created' do
      user_sign_up
      create_event
      visit '/'
      click_link 'Edit Dinner with Thomas'
      fill_in 'Title', with: "Dinner at Thomas' house in Whitechapel"
      click_button 'Update Event'
      expect(page).to have_content "Dinner at Thomas' house in Whitechapel"
      expect(current_path).to eq '/events'
    end
  end

  context 'deleting an event' do

    let!(:dinwithC){Event.create(title: 'Dinner with Chris', description: "Dinner at Chris' house", location: 'BN3 6FU', date: 'Wednesday 7.30pm', size: '3')}

    scenario 'does not let a user delete and event that they have not created' do
      user_sign_up
      visit '/'
      click_link "Delete Dinner with Chris"
      expect(page).to have_content 'You can only delete events that you have created'
      expect(current_path).to eq('/events')
    end

    scenario 'lets a user delete an event they have created' do
      user_sign_up
      visit '/'
      create_event
      click_link "Delete Dinner with Thomas"
      expect(page).to have_content 'Event deleted successfully'
      expect(current_path).to eq '/events'
    end
  end

end








