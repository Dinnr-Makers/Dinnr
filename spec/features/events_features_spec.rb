require 'rails_helper'

feature 'events' do
  context 'no events have been added' do

    scenario 'displays a prompt to add an event' do
      user_sign_up
      visit '/events'
      expect(page).to have_content 'No events yet'
      expect(page).to have_link 'Create event'
    end
  end

  context 'events have been added' do
    scenario 'displays events when an event has been added' do
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

    scenario "shows an error message if the date is invalid" do
      user_sign_up
      visit '/events'
      click_link('Create event', match: :first)
      fill_in 'Title', with: 'Dinner with Thomas'
      fill_in 'Description', with: "Dinner at Thomas' house"
      fill_in 'autocomplete', with: '16 woodchurch road'
      fill_in 'Date', with: '1984-12-30'
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

    scenario 'shows that there are no guests when created' do
      visit '/events'
      click_link (dinwitht.title)
      expect(page).to have_content "No guests yet"
    end


    it "shows a user's avatar as a thumbnail if they have joined the event" do
      john = create(:user, email: 'john@doe.com', password: 'testtest', password_confirmation: 'testtest')
      party = create(:event, user: john, title: "John's Party")
      kate = create(:user, email: 'kate@test.com', password: 'testtest', password_confirmation: 'testtest')
      visit '/'
      click_link('Sign in', match: :prefer_exact)
      fill_in 'Email', with: 'kate@test.com'
      fill_in 'Password', with: 'testtest'
      click_button('LOG IN')
      visit '/'
      click_link(party.title, match: :first)
      click_link('Join Event')
      find(:css, "img.avatar")
      expect(page.find(:css, "img.avatar")['src']).to eq "https://s3-us-west-2.amazonaws.com/dinnr/pictures/chefhatsmall.jpg"
    end
  end

  context 'editing events' do

    scenario 'does not let a user edit an event that they have not created' do
      party = create(:event)
      user_sign_up
      visit '/'
      click_link(party.title, match: :first)
      expect(page).not_to have_content 'Edit'
    end

    scenario 'lets a user edit an event he has created' do
      user_sign_up
      create_event
      visit '/'
      click_link('Dinner with Thomas', match: :first)
      click_link('Edit')
      fill_in 'Title', with: "Dinner at Thomas' house in Whitechapel"
      click_button 'Update Event'
      expect(page).to have_content "Dinner at Thomas' house in Whitechapel"
      expect(current_path).to eq '/events'
    end
  end

  context 'deleting events' do

    scenario 'does not let a user delete and event that they have not created' do
      party = create(:event)
      user_sign_up
      visit '/'
      click_link(party.title, match: :first)
      expect(page).not_to have_content 'Delete'
    end

    scenario 'lets a user delete an event they have created' do
      user_sign_up
      visit '/'
      create_event
      click_link('Dinner with Thomas', match: :first)
      click_link "Delete"
      expect(page).to have_content 'Event deleted successfully'
      expect(current_path).to eq '/events'
    end
  end

  context 'adding images to events' do

    scenario'User can add an image to an event they have created' do
      user = create(:user)
      sign_in
      image = create(:picture)
      user.pictures << image
      create_event
      visit '/'
      click_link('Dinner with Thomas', match: :first)
      click_link("Add Image")
      expect(page).to have_content 'Select an image to add to Dinner with Thomas'
      click_link 'Add'
      expect(page).to have_content "Test Picture"
    end


    scenario 'user can not add an image to an event if they have no images uploaded' do
      user = create(:user)
      sign_in
      create_event
      visit '/'
      click_link('Dinner with Thomas', match: :first)
      click_link("Add Image")
      expect(page).to have_content 'Select an image to add to Dinner with Thomas'
      expect(page).to have_content "No pictures available to add to event"
      expect(page).to have_css "form.new_picture"
    end
  end

  context 'deleting images from events' do

    scenario 'user can delete their own image from an event' do
      user = create(:user)
      sign_in
      image = create(:picture)
      user.pictures << image
      create_event
      visit '/'
      click_link('Dinner with Thomas', match: :first)
      click_link("Add Image")
      expect(page).to have_content 'Select an image to add to Dinner with Thomas'
      click_link 'Add'
      click_link 'Remove Test Picture'
      expect(page).not_to have_content 'Test Picture'
    end
  end

  context "Event with image has been created", js: true do
    scenario "image is visible on frontpage" do
      user1 = create(:user)
      event1 = create(:event, user: user1)
      image = create(:picture, user: user1)
      event1.pictures << image
      visit '/'
      within(:css, "div.card") do
        expect(page.find(:css, "img")["src"]).to eq(image.image.url(:medium))
      end
    end
  end


end
