require 'rails_helper'

RSpec.describe 'LikeDislikes', type: :system do
  before { driven_by(:rack_test) }
  let(:user) { create(:user) }
  let(:post) { build(:post) }

  before :each do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    fill_in 'Add New Post', with: post.content
    click_button 'Save'
  end

  describe 'Like' do
    scenario 'adds a like, for a particular user, to a post' do
      click_link 'Like!'
      expect(page).to have_content 'You liked a post.'
    end
  end

  describe 'Dislike' do
    scenario 'removes the like previously added to a post by the user' do
      click_link 'Like!'
      click_link 'Dislike!'
      expect(page).to have_content 'You disliked a post.'
    end
  end
end
