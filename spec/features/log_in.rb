require 'rails_helper'

RSpec.feature 'User logs in' do
  let(:user) { create(:user, phone_verified: true, email_verified: true) }

  scenario 'With valid username and password' do
    visit login_path
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_content('Dashboard')
    expect(page).to have_content('Logout')
  end

end
