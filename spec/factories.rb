FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name }
    email { Faker::Internet.email}
    phone { "555#{Array.new(7) { rand(10).to_s }.join}"}
    school_id { create(:school).id }
    password "password1234"
    password_confirmation "password1234"
    parent_password "hellohello"
    parent_password_confirmation "hellohello"
    nudges_enabled true
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
    event
    user
  end

  factory :nudge do
    nudger_id { create(:user).id }
    nudgee_id { create(:user).id }
    event_id { create(:event).id }
  end

  factory :location do
    name "ALPHA OMEGA MINISTRIES"
    address "1251 N Parkside Ave"
    city "Chicago"
    state "IL"
    zipcode 60651
    latitude 41.90363
    longitude -87.766557
    is_public true
  end
end
