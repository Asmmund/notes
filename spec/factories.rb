FactoryGirl.define do
  sequence(:random_string) {|n| "String_#{n}" }

  factory :article do
    title { generate(:random_string) }
    body  "<h1>article head</h1>"
  end

end