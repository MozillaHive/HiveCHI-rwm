User.create(username: "bob123", email: "bob@gmail.com", school_id: 1, home_address: "2832 S Homan Ave", preference_1: "Aquatic", preference_2: "Camp", preference_3: "Football")

School.create(name: "Whitney M. Young Magnet High School", address: "211 S Laflin St, Chicago, IL 60607")

Event.create(name: "Tech night fun night", address: "300 S Laflin St, Chicago, IL 60607", start_date_and_time: "2015-02-03T00:00:00+00:00", duration: 2, description: "A really fun time!", organization_id: 1)

Organization.create(name: "Jim's Science Academy", domain_name: "@jimscience.org")

Attendance.create(event_id: 1, user_id: 1, departure_time: "2015-02-03T00:00:55+00:00", method_of_transit: "bus", commitment_status: "Yes")