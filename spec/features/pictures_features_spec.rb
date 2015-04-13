require 'rails_helper'

# def user_sign_up

#   visit '/'
#   click_link('Sign up', match: :first)
#   fill_in('Email', with: 'test@example.com')
#   fill_in('Password', with: 'testtest')
#   fill_in('Password confirmation', with: 'testtest')
#   click_button('Sign up')

# end

# def create_event
#   visit '/events'
#   click_link('Create event', match: :first)
#   fill_in 'Title', with: 'Dinner with Thomas'
#   fill_in 'Description', with: "Dinner at Thomas' house"
#   fill_in 'autocomplete', with: '16 woodchurch road'
#   fill_in 'Date', with: 'Tuesday 7.30pm'
#   fill_in 'Size', with: '2'
#   click_button 'Create Event'
# end


feature 'Pictures' do

  context 'no pictures uploaded yet' do

    scenario 'should display a prompt to add a picture' do
      visit '/pictures'
      expect(page).to have_content 'No pictures yet'
      expect(page).to have_link "Add a picture"

    end

  end

  context 'pictures have been added' do

    before do
      Picture.create(title: 'First picture')
    end

    scenario 'display pictures' do
      visit '/pictures'
      expect(page).to have_content('First picture')
      expect(page).not_to have_content('No pictures yet')
    end
  end

end