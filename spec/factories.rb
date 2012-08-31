FactoryGirl.define do
  factory :user do
    name  "Skip Davis"
    email "skipdavis@gmail.com"
    password "myTempPass"
    password_confirmation "myTempPass"
  end
end