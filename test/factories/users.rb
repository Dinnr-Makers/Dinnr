FactoryGirl.define do
  factory :user, aliases:[:author, :host] do
    first_name "John"
    last_name  "Doe"
    email "john@doe.com"
    password "testtest"
    password_confirmation "testtest"
  end
end