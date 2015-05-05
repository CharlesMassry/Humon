FactoryGirl.define do
  factory :user do
    device_token { SecureRandom.urlsafe_base64 }
    first_name "MyString"
    last_name "MyString"
  end
end
