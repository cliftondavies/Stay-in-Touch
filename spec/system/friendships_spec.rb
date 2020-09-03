require 'rails_helper'

RSpec.describe 'Friendships', type: :system do
  before { driven_by(:rack_test) }
  let(:user_one) { create(:user) }
  let(:user_two) { create(:user) }
  let(:user_three) { create(:user) }

  before :each do
    visit new_user_session_path
    fill_in 'Email', with: user_one.email
    fill_in 'Password', with: user_one.password
    click_button 'Log in'
  end

  describe 'Invite to friendship' do
    scenario 'sends a friend request to another user' do
      visit user_path(user_two)
      click_button 'Invite to friendship'
      expect(page).to have_content 'Your friend request has been sent!'
    end
  end

  describe 'Accept' do
    scenario 'creates mutual friendship with another user' do
      visit user_path(user_two)
      click_button 'Invite to friendship'
      click_link 'Sign out'
      fill_in 'Email', with: user_two.email
      fill_in 'Password', with: user_two.password
      click_button 'Log in'
      visit user_path(user_one)
      click_link 'Accept'
      expect(page).to have_content "You are now friends with #{user_one.name}!"
    end
  end

  describe 'Decline' do
    scenario 'rejects a friend request from another user' do
      visit user_path(user_three)
      click_button 'Invite to friendship'
      click_link 'Sign out'
      fill_in 'Email', with: user_three.email
      fill_in 'Password', with: user_three.password
      click_button 'Log in'
      visit user_path(user_one)
      click_link 'Decline'
      expect(page).to have_content 'Friend request rejected.'
    end
  end
end
