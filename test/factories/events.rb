FactoryGirl.define do
  factory :event, :class => 'Event', traits: [:stub_geocoding_if_coordinates_already_present] do
    trait :stub_geocoding_if_coordinates_already_present do
      after(:build) do |object|
        if [object.latitude, object.longitude].all?(&:present?)
          # hand made stub
          class << object
            def geocode
              [latitude, longitude]
            end
          end
        end
      end
    end
    title "Pauls Birthday Party"
    description "Party for Paul's 21. birthday"
    location "22 Sancroft Street, London, United Kingdom"
    date "2016-12-12 00:00:00"
    size 4
    user_id nil
    housenumber "22"
    street "Sancroft St"
    city "London"
    country "United Kingdom"
    postcode "SE11 5UG"

    factory :geocoded_event do
      latitude 51.4890062
      longitude -0.1127739
    end
  end
end