User.create(username: "bob123", email: "bob@gmail.com", school_id: 1, home_address: "2832 S Homan Ave")

School.create(name: "Whitney M. Young Magnet High School", address: "211 S Laflin St, Chicago, IL 60607")

Event.create(name: "Tech night fun night", address: "300 S Laflin St, Chicago, IL 60607", start_date_and_time: "July 31, 2015, 5:00pm", duration: "2 hours", description_url: "http://www.google.com", organization_id: 1)

Organization.create(name: "Jim's Science Academy", domain_name: "@jimscience.org")

Attendance.create(event_id: 1, user_id: 1, estimated_arrival_time: "10:20pm", commitment_status: "Yes")