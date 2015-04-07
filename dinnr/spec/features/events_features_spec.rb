require 'rails_helper'

feature 'events' do
  context 'no events have been added' do
    scenario 'should display a prompt to add an event' do
      visit '/events'
      expect(page).to have_content 'No events yet'
      expect(page).to have_link 'Add an event'
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
      visit '/events'
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

  context 'viewing an event' do

    let!(:dinwitht){Event.create(title: 'Dinner with Thomas', description: "Dinner at Thomas' house", location: 'E1 1EJ', date: 'Tuesday 7.30pm', size: '3')}

    scenario 'lets a user view an event' do
      visit '/events'
      click_link ('Dinner with Thomas')
      expect(page).to have_content "Dinner at Thomas' house"
      expect(current_path).to eq "/events/#{dinwitht.id}"
    end
  end

end