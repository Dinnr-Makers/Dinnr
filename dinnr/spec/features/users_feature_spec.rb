require 'rails_helper'

feature 'users' do
  context 'user not signed in and on he home page' do

    scenario 'should see a sign in and sign up link' do
      visit '/'
      expect(page).to have_content("Sign in")
      expect(page).to have_content("Sign up")
    end
  end

end