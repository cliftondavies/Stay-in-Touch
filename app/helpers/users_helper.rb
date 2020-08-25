module UsersHelper
  def invite(user)
    unless user == current_user || current_user.friend?(user)
      button_to 'Invite to friendship', user_friend_requests_path(user), method: :post
    end
  end

  def accept_decline(user)
    if current_user.pending_invite?(user)
      (button_to "Accept", friend_request_path(FriendRequest.pending_request(user, current_user)), method: :patch) + (button_to "Decline", friend_request_path(FriendRequest.pending_request(user, current_user)), method: :delete, data: {confirm: "Really decline the request?"})
    end
  end
end
