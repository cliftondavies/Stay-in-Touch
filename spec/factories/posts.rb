require 'faker'

FactoryBot.define do
  factory :post do
    user
    content { Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false) }
  end
end
