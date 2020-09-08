require 'rails_helper'

RSpec.describe 'Comments', type: :system do
  before { driven_by(:rack_test) }
  let(:user) { create(:user) }
  let(:post) { build(:post) }
  let(:comment) { build(:comment) }

  describe 'Comment' do
    before :each do
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
      fill_in 'Add New Post', with: post.content
      click_button 'Save'
    end

    context 'with comment content' do
      scenario 'creates a new post comment' do
        fill_in 'Add new Comment', with: comment.content
        click_button 'Comment'
        expect(page).to have_content 'Comment was successfully created.'
      end
    end

    context 'without comment content' do
      scenario 'does not create a new post comment' do
        fill_in 'Add new Comment', with: ''
        click_button 'Comment'
        expect(page).to have_content "Content can't be blank"
      end
    end
  end
end
