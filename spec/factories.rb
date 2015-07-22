FactoryGirl.define do
  factory :user do
    username Faker::Internet.user_name
    email Faker::Internet.email
    phone Faker::PhoneNumber.cell_phone
    school_id 1
    password "hellohello"
    password_confirmation "hellohello"
  end

  factory :school do
    name "#{Faker::Company.name} Academy"
    address "#{Faker::Address.street_address}, Chicago, IL"
  end
end
