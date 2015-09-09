FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email}
    phone { "555#{Array.new(7) { rand(10).to_s }.join}"}
    password "password1234"
    password_confirmation "password1234"
    nudges_enabled true
  end

  factory :student do
    username { Faker::Internet.user_name }
    school_id { create(:school).id }
    address { "#{Faker::Address.street_address}, Chicago, IL" }
    user_attributes { FactoryGirl.attributes_for(:user) }
  end

  factory :school do
    name { "#{Faker::Company.name} High School" }
    address { "#{Faker::Address.street_address}, Chicago, IL" }
  end

  factory :event do
    name { "Test Event #{SecureRandom.hex(10)}" }
    address "875 N Michigan Ave, Chicago, IL"
    start_date_and_time { Date.tomorrow.midday }
    duration { rand(4) + 1 }
    description "This is an automatically generated test event."
    event_type "Soccer"
  end

  factory :attendance do
    event_id { create(:event).id }
    user_id { create(:user).id }
  end

  factory :nudge do
    nudger_id { create(:user).id }
    nudgee_id { create(:user).id }
    event_id { create(:event).id }
  end
end
