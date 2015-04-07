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

end