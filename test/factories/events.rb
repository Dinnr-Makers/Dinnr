FactoryGirl.define do
  factory :event, :class => 'Event' do
    title "Pauls Birthday Party"
    description "Party for Paul's 21. birthday"
    location "22 Sancroft Street, London, United Kingdom"
    date '2020-04-30'
    time '17:20:00.000'
    size 4
    # user_id nil
    housenumber "22"
    street "Sancroft St"
    city "London"
    country "United Kingdom"
    postcode "SE11 5UG"
  end

end