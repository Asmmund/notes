FactoryGirl.define do
  sequence(:random_string) {|n| "String_#{n}" }

  factory :user do
    sequence(:name)  { |n| "User#{n}" }
    sequence(:email)  { |n| "#{n}@email.com" }
    articles { [FactoryGirl.create(:article)] }
    password "MyString"
    password_confirmation "MyString"
    linkedin "MyString"
    twitter "MyString"
    facebook "MyString"
    web "MyString"
  end

  factory :article do
    title { generate(:random_string) }
    body  "<h1>article head</h1>"
    user_id 1
  end

end