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

def sign_in
  visit '/'
  click_link('Sign in', match: :first)
  fill_in 'Email', with: 'john@doe.com'
  fill_in 'Password', with: 'testtest'
  click_button('Log in')
end

def user_one_sign_up
  visit '/'
  click_link('Sign up', match: :first)
  fill_in('user[first_name]', with: 'firstname')
  fill_in('user[last_name]', with: 'lastname')
  fill_in('Email', with: 'test@example.com')
  fill_in('Password', with: 'testtest')
  fill_in('Password confirmation', with: 'testtest')
  click_button('Sign up')
end

def user_two_sign_up
  visit '/'
  click_link('Sign up', match: :first)
  fill_in('user[first_name]', with: 'alice')
  fill_in('user[last_name]', with: 'alice surname')
  fill_in('Email', with: 'alice@example.com')
  fill_in('Password', with: 'password')
  fill_in('Password confirmation', with: 'password')
  click_button('Sign up')
end

def user_three_sign_up
  visit '/'
  click_link('Sign up', match: :first)
  fill_in('Email', with: 'chris@testy.com')
  fill_in('Password', with: 'password')
  fill_in('Password confirmation', with: 'password')
  click_button('Sign up')
end

def user_four_sign_up
  visit '/'
  click_link('Sign up', match: :first)
  fill_in('Email', with: 'thomas@dinnr.com')
  fill_in('Password', with: 'password')
  fill_in('Password confirmation', with: 'password')
  click_button('Sign up')
end

def user_one_create_event
  visit '/events'
  click_link('Create event', match: :first)
  fill_in 'Title', with: 'Dinner with Thomas'
  fill_in 'Description', with: "Dinner at Thomas' house"
  fill_in 'autocomplete', with: 'E1 1EJ'
  fill_in 'Date', with: '2020-04-30'
  fill_in 'Time', with: '17:20:00.000'
  fill_in 'Size', with: '2'
  click_button 'Create Event'
end