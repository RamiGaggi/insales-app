# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    sequence(:insales_subdomain) { |num| "#{num}insales.io" }
    sequence(:insales_id) { |num| num + 1000 }
    sequence(:insales_application_password) { |num| "#{num}password" }
  end
end
