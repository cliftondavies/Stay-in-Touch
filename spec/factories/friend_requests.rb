require 'faker'

FactoryBot.define do
  factory :friend_request, aliases: %i[sent_requests received_requests] do
    befriender
    befriendee
    status { 'pending' }
  end
end
