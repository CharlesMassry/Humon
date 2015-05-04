FactoryGirl.define do
  factory :event do
    address "MyString"
    ended_at "2015-05-02 11:33:43"
    lat 40.8044920
    lon(-73.9562990)
    name "MyString"
    started_at "2015-05-02 11:33:43"
    association :owner, factory: :user
  end
end
