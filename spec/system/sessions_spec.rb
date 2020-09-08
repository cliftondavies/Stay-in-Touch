require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  before { driven_by(:rack_test) }
  before(:each) { visit new_user_session_path }
  let(:user) { create(:user) }

  describe 'Sign In' do
    context 'with valid email and password' do
      scenario 'authenticates the user' do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Log in'
        expect(page).to have_content 'Signed in successfully.'
      end
    end

    context 'with invalid email or password' do
      scenario 'does not authenticate the user' do
        fill_in 'Email', with: 'testuser@email.com'
        fill_in 'Password', with: '789101112'
        click_button 'Log in'
        expect(page).to have_content 'Invalid Email or password.'
      end
    end
  end

  describe 'Sign Out' do
    scenario 'ends the user session' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
      click_link 'Sign out'
      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end
end
