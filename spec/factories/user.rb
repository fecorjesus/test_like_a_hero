# spec/factories/users.rb
FactoryBot.define do
 factory :user do
    nickname { FFaker::Name.first_name }
    kind { %w[knight wizard].sample }
    level { FFaker::Random.rand(1..99) }
 end
end
