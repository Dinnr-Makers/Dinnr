def user_sign_up
  visit '/'
  click_link('Sign up', match: :prefer_exact)
  fill_in('Email', with: 'test@example.com')
  fill_in('Password', with: 'testtest')
  fill_in('Password confirmation', with: 'testtest')
  click_button('Sign up')
end

def create_event
  visit '/events'
  click_link('Create event', match: :prefer_exact)
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
  click_link('Sign in', match: :prefer_exact)
  fill_in 'Email', with: 'john@doe.com'
  fill_in 'Password', with: 'testtest'
  click_button('LOG IN')
end

def user_one_sign_up
  visit '/'
  click_link('Sign up', match: :prefer_exact)
  fill_in('user[first_name]', with: 'firstname')
  fill_in('user[last_name]', with: 'lastname')
  fill_in('Email', with: 'test@example.com')
  fill_in('Password', with: 'testtest')
  fill_in('Password confirmation', with: 'testtest')
  click_button('Sign up')
end

def user_two_sign_up
  visit '/'
  click_link('Sign up', match: :prefer_exact)
  fill_in('user[first_name]', with: 'alice')
  fill_in('user[last_name]', with: 'alice surname')
  fill_in('Email', with: 'alice@example.com')
  fill_in('Password', with: 'password')
  fill_in('Password confirmation', with: 'password')
  click_button('Sign up')
end

def user_three_sign_up
  visit '/'
  click_link('Sign up', match: :prefer_exact)
  fill_in('Email', with: 'chris@testy.com')
  fill_in('Password', with: 'password')
  fill_in('Password confirmation', with: 'password')
  click_button('Sign up')
end

def user_four_sign_up
  visit '/'
  click_link('Sign up', match: :prefer_exact)
  fill_in('Email', with: 'thomas@dinnr.com')
  fill_in('Password', with: 'password')
  fill_in('Password confirmation', with: 'password')
  click_button('Sign up')
end

def user_one_create_event
  visit '/events'
  click_link('Create event', match: :prefer_exact)
  fill_in 'Title', with: 'Dinner with Thomas'
  fill_in 'Description', with: "Dinner at Thomas' house"
  fill_in 'autocomplete', with: 'E1 1EJ'
  fill_in 'Date', with: '2020-04-30'
  fill_in 'Time', with: '17:20:00.000'
  fill_in 'Size', with: '2'
  click_button 'Create Event'
end

# reviews features spec

def leave_review(thoughts, rating)
  visit 'events'
  click_link 'Makers Welcome Drinks'
  click_link 'Review'
  fill_in 'Thoughts', with: thoughts
  select rating, from: 'Rating'
  click_button 'Leave Review'
end

def makers_drinks
  build(:event,
        title: 'Makers Welcome Drinks',
        description: 'Welcome drinks for the Feb Cohort',
        location: '50 Commercial Street, London, United Kingdom',
        date: '2015-02-02',
        time: '18:30:00.000',
        size: 25,
        user_id: nil,
        housenumber: '50',
        street: 'Commercial Street',
        city: 'London',
        country: 'United Kingdom',
        postcode: 'E1 6LT',
        id: 5)
end

def create_user_john
  john = create(:user,
                id: 3,
                email: 'john@doe.com',
                password: 'testtest',
                password_confirmation: 'testtest')
end

def feedback
  create(:review, id: 7, user_id: 3, event_id: 5, thoughts: 'so so', rating: 3)
end

def ticket
  create(:booking, user_id: 3, event_id: 5)
end

# pictures features spec

def create_picture
  visit '/pictures'
  click_link 'Add a picture'
  fill_in 'Title', with: 'Test picture'
  click_button 'Create Picture'
end

# bookings features spec

def join_event
  click_link 'Dinner with Thomas'
  click_link 'Join Event'
end
