require 'faker'

FactoryBot.define do
  factory :comment do
    user
    post
    content { Faker::Lorem.paragraph_by_chars(number: 100, supplemental: false) }
  end
end
