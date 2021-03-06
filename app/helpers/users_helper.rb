module UsersHelper
  def invite(user)
    return if user == current_user || current_user.confirmed_friend?(user, current_user) ||
              !current_user.sent_requests.invited?(user) || current_user.pending_friend?(user, current_user)

    button_to 'Invite to friendship', user_friend_requests_path(user), method: :post
  end

  def accept_decline(user)
    return unless current_user.pending_friend?(user, current_user)

    (button_to 'Accept', friend_request_path(FriendRequest.pending_request(user, current_user)), method: :patch) +
      (button_to 'Decline', friend_request_path(FriendRequest.pending_request(user, current_user)),
                 method: :delete, data: { confirm: 'Really decline the request?' })
  end
end
