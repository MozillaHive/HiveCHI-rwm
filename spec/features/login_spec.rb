require 'rails_helper'

RSpec.feature 'User logs in' do
  let(:student) do
    student = create(:student)
    student.user.update(phone_verified: true, email_verified: true)
    student
  end

  scenario 'With valid username and password' do
    log_in_as_student
    expect(page).to have_content('Dashboard')
    expect(page).to have_content('Logout')
  end

  scenario "With invalid password" do
    visit login_path
    fill_in 'Username', with: student.username
    fill_in 'Password', with: "password1235"
    click_button 'Log in'
    expect(page).not_to have_content('Dashboard')
    expect(page).to have_content('Invalid username or password')
  end

  scenario "With invalid username" do
    visit login_path
    fill_in 'Username', with: "usernameisfake"
    fill_in 'Password', with: student.user.password
    click_button 'Log in'
    expect(page).not_to have_content('Dashboard')
    expect(page).to have_content('Invalid username or password')
  end

end
