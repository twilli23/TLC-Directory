# frozen_string_literal: true

FactoryBot.define do
  factory :website do
    url { Faker::Internet.url }

    factory :website_user_association do
      association :webable, factory: :user_faker
    end
  end
end
