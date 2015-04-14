require 'rails_helper'

def create_picture
  visit '/pictures'
  click_link 'Add a picture'
  fill_in 'Title', with: 'Test picture'
  click_button 'Create Picture'
end

feature 'Pictures' do

  context 'no pictures uploaded yet' do

    scenario 'should display a prompt to add a picture' do
      visit '/pictures'
      expect(page).to have_content 'No pictures yet'
      expect(page).to have_link "Add a picture"

    end

  end

  context 'pictures have been added' do

    scenario 'display pictures' do
      user_one_sign_up
      create_picture
      visit '/pictures'
      expect(page).to have_content('Test picture')
      expect(page).not_to have_content('No pictures yet')
    end
  end

  context 'creating pictures' do
    scenario 'prompts user to fill out form' do
      user_one_sign_up
      create_picture
      visit '/pictures'
      expect(page).to have_content 'Test picture'
      expect(current_path).to eq '/pictures'
    end
  end

  xcontext 'viewing pictures' do
    let!(:piccy){Picture.create(title: 'Test picture', user_id: 4)}
    let!(:user) {User.create(first_name: 'firstname', last_name: 'lastname', email: 'test@example.com', password: 'testtest', password_confirmation: 'testtest', id: 4 )}

    scenario 'lets a user view a picture' do
      visit '/'
      click_link('Sign in', match: :first)
      fill_in 'Email', with: 'test@example.com'
      fill_in 'Password', with: 'testtest'
      click_button('Log in')
      visit '/pictures'
      save_and_open_page
      click_link 'Test picture'
      expect(page).to have_content 'Test picture'
      expect(current_path).to eq "/pictures/#{piccy.id}"
    end
  end

  context 'deleting pictures' do

    scenario 'user can delete a photo from their library' do
      user_one_sign_up
      create_picture
      visit '/pictures'
      click_link 'Delete Test picture'
      expect(page).not_to have_content 'Test picture'
      expect(page).to have_content 'Picture deleted successfully'
    end

    scenario 'only the uploader of a photo can delete it' do
      user_one_sign_up
      visit '/pictures'
      click_link 'Add a picture'
      fill_in 'Title', with: 'Test picture'
      click_button 'Create Picture'
      click_link('Sign out', match: :first)
      user_two_sign_up
      visit '/pictures'
      expect(page).to have_content 'No pictures yet'
    end
  end

end