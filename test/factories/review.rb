FactoryGirl.define do
  factory :review, :class => 'Review' do
    thoughts 'so so'
    rating 3
    event_id nil
    user_id nil
  end
end
