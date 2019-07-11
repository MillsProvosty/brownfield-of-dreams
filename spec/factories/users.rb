# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Dog.name }
    last_name { Faker::Artist.name }
    password { Faker::Color.color_name }
    role { :default }
  end

  factory :user_with_github, parent: :user do
    github_token { ENV['GITHUB_API_KEY'] }
    github_handle { 'MillsProvosty' }
  end

  factory :admin, parent: :user do
    role { :admin }
  end
end
