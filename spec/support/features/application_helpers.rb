module Features
  module ApplicationHelpers

    def log_in(user)
      visit login_path
      fill_in 'Username', with: user.username
      fill_in 'Password', with: user.password
      click_button 'Log in'
    end

    def register(user, school)
      visit register_path
      fill_in "Username", with: user.username
      fill_in "Email", with: user.email
      fill_in "Phone", with: user.phone
      select school.name, from: "user_school_id"
      fill_in "Password", with: user.password
      fill_in "Password confirmation", with: user.password_confirmation
      fill_in "Parent password", with: user.parent_password
      fill_in "Parent password confirmation", with: user.parent_password_confirmation
      click_button "Create User"
    end

  end
end
