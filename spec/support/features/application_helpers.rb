module Features
  module ApplicationHelpers

    def log_in_as_student(student = nil)
      student = create(:verified_student) unless student
      visit login_path
      fill_in 'Username', with: student.username
      fill_in 'Password', with: student.user.password
      click_button 'Log in'
      sleep(1)
    end

    def log_in_as_service_provider(service_provider = nil)
      service_provider = create(:verified_service_provider) unless service_provider
      visit login_path
      fill_in "Username", with: service_provider.user.email
      fill_in 'Password', with: service_provider.user.password
      click_button 'Log in'
      sleep(1)
    end

    def log_in_as_admin(admin = nil)
      admin = create(:admin) unless admin
      visit login_path
      fill_in "Username", with: admin.user.email
      fill_in 'Password', with: admin.user.password
      click_button 'Log in'
      sleep(1)
    end

    def register_as_student(student = nil)
      student = build(:student) if student.nil?
      visit register_path
      fill_in "Username", with: student.username
      fill_in "Email", with: student.user.email
      fill_in "Phone", with: student.user.phone
      select student.school.name, from: "student_school_id"
      fill_in "Password", with: student.user.password
      fill_in "Password confirmation", with: student.user.password_confirmation
      click_button "Submit"
    end

    def register_as_service_provider(service_provider = nil)
      service_provider = build(:service_provider) unless service_provider
      visit register_path
      click_link "Service Provider"
      fill_in "Email", with: service_provider.user.email
      fill_in "Phone", with: service_provider.user.phone
      fill_in "Password", with: service_provider.user.password
      fill_in "Password confirmation", with: service_provider.user.password_confirmation
      click_button "Submit"
    end
  end
end
