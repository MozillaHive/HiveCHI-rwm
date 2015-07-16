FactoryGirl.define do
  factory :user do
    username "exampleuser1"
    email "user@example.com"
    phone "5555555555"
    school_id 1
    password "hellohello"
    password_confirmation "hellohello"
  end

  factory :school do
    name "Example Academy"
    address "1 W Wacker Dr"
  end
end
