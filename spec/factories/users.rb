FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "example#{n}@email.com" }
    password "example_password"   
  end

end
