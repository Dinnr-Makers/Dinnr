require 'rails_helper'

feature 'users' do

  let!(:dinwithC){create(:event)}

  context 'user not signed in and on the home page' do

    it 'does see a sign in and sign up link' do
      visit '/'
      expect(page).to have_content("Sign in")
      expect(page).to have_content("Sign up")
    end

    it 'does not see a sign out link' do
      visit '/'
      expect(page).not_to have_link('Sign out')
    end

    it 'is not be able to create a new event' do
      visit '/'
      expect(page).not_to have_content 'Create event'
    end

    it 'is sent email when they have forgotten their password' do
      visit '/'
      user_two_sign_up
      click_link('Sign out', match: :prefer_exact)
      visit '/'
      click_link('Sign in', match: :prefer_exact)
      click_link 'Forgot your password?'
      fill_in 'Email', with: 'alice@example.com'
      click_button 'Send me reset password instructions'
      expect(page).to have_content "You will receive an email with instructions on how to reset your password in a few minutes."
    end

    it 'does not see an edit link' do
      visit '/'
      expect(page).not_to have_link('Edit')
    end

    it 'does not see a delete link' do
      visit '/'
      expect(page).not_to have_link('Delete')
    end

    # it 'does not see a profile picture' do
    #   visit '/'
    #   expect(page).not_to have_content
    # end

  end

  context 'user signed in and on the home page' do

    before do
      user_one_sign_up
    end

    it 'does see a sign out link' do
      visit '/'
      expect(page).to have_link('Sign out')
    end

    it 'does not see a sign in or sign up link' do
      visit '/'
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end

    it 'is able to create a new event' do
      create_event
      expect(page).to have_content 'Dinner with Thomas'
      expect(current_path).to eq '/events'
    end

    it "sees a profile picture in the menu bar" do
      visit '/'
      find(:css, "img.menu-avatar")
      expect(page.find(:css, "img.menu-avatar")['src']).to eq "https://s3-us-west-2.amazonaws.com/dinnr/pictures/chefhatsmall.jpg"
    end
  end
end

feature 'users profile page' do

  context 'no users signed up' do
    it 'displays no users yet' do
      visit '/users'
      expect(page).to have_content 'No users yet'
    end
  end

  context 'user signed in and on profile page' do
    it 'displays the user details' do
      user_one_sign_up
      visit '/users'
      expect(page).to have_content 'firstname'
    end

    it 'displays the user\'s last name' do
      user_one_sign_up
      visit '/users'
      expect(page).to have_content 'lastname'
    end

  end

end

feature 'updating profile details' do

  it 'is able to change the users first name' do
    user_one_sign_up
    visit 'users/edit'
    fill_in('First name', with: 'Chris')
    fill_in('Current password', with: 'testtest')
    click_button('Update')
    expect(page).to have_content 'Your account has been updated successfully.'
    visit '/users'
    expect(page).to have_content 'Chris'
  end

  it 'is able to change the users last name' do
    user_one_sign_up
    visit 'users/edit'
    fill_in('Last name', with: 'Ward')
    fill_in('Current password', with: 'testtest')
    click_button('Update')
    expect(page).to have_content 'Your account has been updated successfully.'
    visit '/users'
    expect(page).to have_content 'Ward'
  end

end

