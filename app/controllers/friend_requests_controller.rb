class FriendRequestsController < ApplicationController
  before_action :authenticate_user!

  def create
    @friend_request = current_user.sent_requests.build(befriendee_id: params[:user_id])
    @friend_request.status = 'pending'
    if @friend_request.save
      # flash[:success] = "Your friend request has been sent!"
      # redirect_to posts_path, notice: 'Your friend request has been sent!'
      redirect_back fallback_location: root_path, notice: 'Your friend request has been sent!'
    else
      flash.now[:alert] = "Could not send request. Please try again"
      render 'users/index'
    end
  end

  def update
    @friend_request = FriendRequest.find(params[:id])
    @friend_request.status = 'accepted'
    if @friend_request.save
      # redirect_to posts_path, notice: "You are now friends with #{@friend_request.befriender.name}!"
      redirect_back fallback_location: root_path, notice: "You are now friends with #{@friend_request.befriender.name}!"
    else
      flash.now[:alert] = 'Could not accept request. Please try again'
      render 'posts/index'
    end
  end

  def destroy
    @friend_request = FriendRequest.find(params[:id])
    @friend_request.destroy
    # redirect_to posts_path, notice: 'Friend request rejected.'
    redirect_back fallback_location: root_path, notice: 'Friend request rejected.'
    # if @object.destroy
    #   flash[:success] = 'Object was successfully deleted.'
    #   redirect_to objects_url
    # else
    #   flash[:error] = 'Something went wrong'
    #   redirect_to objects_url
    # end
  end
end
