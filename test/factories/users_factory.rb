# == Schema Information
#
# Table name: users
#
#  id          :bigint           not null, primary key
#  description :text
#  email       :string
#  github_name :string
#  name        :string(30)
#  rating      :decimal(3, 2)    default(0.0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_users_on_email        (email)
#  index_users_on_github_name  (github_name)
#  index_users_on_name         (name)
#  index_users_on_rating       (rating)
#
FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    github_name { Faker::Internet.unique.username(specifier: 8..30, separators: %w[-]) }
    name { Faker::Name.name }
    rating { Faker::Number.between(from: 1, to: 5).to_f }
  end
end