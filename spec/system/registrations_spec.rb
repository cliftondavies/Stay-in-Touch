require 'rails_helper'

RSpec.describe "Registrations", type: :system do
  before { driven_by(:rack_test) }
  let(:user) { create(:user) }

  describe 'Sign Up' do
    before(:each) { visit new_user_registration_path }

    context 'with sign up email available' do
      scenario 'creates a new user account' do
        fill_in 'Name', with: 'testuser'
        fill_in 'Email', with: 'testuser@email.com'
        fill_in 'Password', with: '789101112'
        fill_in 'Password confirmation', with: '789101112'
        click_button 'Sign up'
        expect(page).to have_content 'Welcome! You have signed up successfully.'
      end
    end

    context 'with sign up email unavailable' do
      scenario 'does not create a new user account' do
        fill_in 'Name', with: 'testuser'
        fill_in 'Email', with: user.email
        fill_in 'Password', with: '789101112'
        fill_in 'Password confirmation', with: '789101112'
        click_button 'Sign up'
        expect(page).to have_content 'Email has already been taken'
      end
    end
  end
end
