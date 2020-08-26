require 'rails_helper'

RSpec.describe "Sessions", type: :system do
  before { driven_by(:rack_test) }
  let(:user) { create(:user) }

  describe 'Sign In' do
    before(:each) { visit new_user_session_path }

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
end
