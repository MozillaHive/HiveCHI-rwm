module Features
  module ApplicationHelpers

    def log_in_as_student(student = nil)
      if student.nil?
        student = create(:student)
        student.user.update(phone_verified: true, email_verified: true)
      end
      visit login_path
      fill_in 'Username', with: student.username
      fill_in 'Password', with: student.user.password
      click_button 'Log in'
      sleep(1)
    end

    def register_as_student(student = nil)
      student = create(:student) if student.nil?
      visit register_path
      fill_in "Username", with: student.username
      fill_in "Email", with: student.user.email
      fill_in "Phone", with: student.user.phone
      select student.school.name, from: "student_school_id"
      fill_in "Password", with: student.user.password
      fill_in "Password confirmation", with: student.user.password_confirmation
      click_button "Submit"
    end

    def register_as_parent(parent = nil)
      parent = create(:parent) if parent.nil?
      visit register_path
      click_link "Parent"
      fill_in "Email", with: parent.user.email
      fill_in "Phone", with: parent.user.phone
      fill_in "Password", with: parent.user.password
      fill_in "Password confirmation", with: parent.user.password_confirmation
      click_button "Submit"
    end

  end
end
