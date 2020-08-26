require 'faker'

FactoryBot.define do
  factory :user, aliases: %i[befriender befriendee] do
    name { Faker::Internet.username(specifier: 4..20) }
    email { Faker::Internet.unique.safe_email }
    encrypted_password { Faker::Internet.password(min_length: 6) }
  end
end
