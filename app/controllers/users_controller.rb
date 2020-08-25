class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @friend_request = current_user.sent_requests.build
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @friend_request = current_user.sent_requests.build
  end
end
