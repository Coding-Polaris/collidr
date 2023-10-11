FactoryBot.define do
  factory :post do
    user { create(:user) }
    title { Faker::Lorem.sentence }    
    body { Faker::Lorem.paragraph }    
  end
end
