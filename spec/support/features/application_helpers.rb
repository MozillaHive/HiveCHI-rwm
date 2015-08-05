module Features
  module ApplicationHelpers

    def log_in(user)
      visit login_path
      fill_in 'Username', with: user.username
      fill_in 'Password', with: user.password
      click_button 'Log in'
    end
  end
end
