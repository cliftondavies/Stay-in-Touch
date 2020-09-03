require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  before { driven_by(:rack_test) }
  let(:user) { create(:user) }
  let(:post) { build(:post) }

  describe 'Add New Post' do
    before :each do
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
    end

    context 'with post content' do
      scenario 'creates a new post' do
        fill_in 'Add New Post', with: post.content
        click_button 'Save'
        expect(page).to have_content 'Post was successfully created.'
      end
    end

    context 'without post content' do
      scenario 'does not create a new post' do
        fill_in 'Add New Post', with: ''
        click_button 'Save'
        expect(page).to have_content "Post could not be saved. Content can't be blank"
      end
    end
  end
end
