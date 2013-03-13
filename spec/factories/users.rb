# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "User#{n}" }
    sequence(:email)  { |n| "#{n}@email.com" }
    password "MyString"
    password_confirmation "MyString"
    linkedin "MyString"
    twitter "MyString"
    facebook "MyString"
    web "MyString"
  end
end
