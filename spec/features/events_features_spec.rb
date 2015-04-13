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
  fill_in 'autocomplete', with: '16 woodchurch road'
  fill_in 'Date', with: '2020-04-30'
  fill_in 'Time', with: '17:20:00.000'
  fill_in 'Size', with: '2'
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
    scenario 'display events' do
      event = create(:event)
      visit '/events'
      expect(page).to have_content event.title
    end
  end

  context 'adding an event' do

    scenario 'prompts a user to fill out a form and then displays the new event' do
      user_sign_up
      create_event
      expect(page).to have_content 'Dinner with Thomas'
      expect(current_path).to eq '/events'
    end

    scenario "Shows error message if date is invalid" do
      user_sign_up
      visit '/events'
      click_link('Create event', match: :first)
      fill_in 'Title', with: 'Dinner with Thomas'
      fill_in 'Description', with: "Dinner at Thomas' house"
      fill_in 'autocomplete', with: '16 woodchurch road'
      fill_in 'Date', with: '1984-04-30'
      fill_in 'Time', with: '17:20:00.000'
      fill_in 'Size', with: '2'
      click_button 'Create Event'
      expect(page).to have_content("Date is not valid")
    end
  end

  context 'viewing an event' do    
    let!(:dinwitht){create(:event)}

    scenario 'lets a user view an event' do
      visit '/events'
      click_link (dinwitht.title)
      expect(page).to have_content dinwitht.description
      expect(current_path).to eq "/events/#{dinwitht.id}"
    end

    scenario 'should show that there are no guests when created' do
      visit '/events'
      click_link (dinwitht.title)
      expect(page).to have_content "No guests yet"
    end
  end

  context 'editing events' do
    
    scenario 'does not let a user edit an event that they have not created' do
      create(:event)
      user_sign_up
      visit '/'
      click_link('Edit', match: :first)
      expect(page).to have_content 'You can only edit events that you have created'
      expect(current_path).to eq('/events')
    end

    scenario 'lets a user edit an event he has created' do
      user_sign_up
      create_event
      visit '/'
      click_link('Edit', match: :first)
      fill_in 'Title', with: "Dinner at Thomas' house in Whitechapel"
      click_button 'Update Event'
      expect(page).to have_content "Dinner at Thomas' house in Whitechapel"
      expect(current_path).to eq '/events'
    end
  end

  context 'deleting events' do

    scenario 'does not let a user delete and event that they have not created' do
      create(:event)
      user_sign_up
      visit '/'
      click_link("Delete", match: :first)
      expect(page).to have_content 'You can only delete events that you have created'
      expect(current_path).to eq('/events')
    end

    scenario 'lets a user delete an event they have created' do
      user_sign_up
      visit '/'
      create_event
      click_link "Delete"
      expect(page).to have_content 'Event deleted successfully'
      expect(current_path).to eq '/events'
    end
  end
end
