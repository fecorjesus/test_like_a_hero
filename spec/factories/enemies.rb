FactoryBot.define do
  factory :enemy do
    name { FFaker::Lorem.word.to_s }
    power_base { FFaker::Random.rand(1..9999).to_i }
    power_step { FFaker::Random.rand(1..999).to_i }
    level { FFaker::Random.rand(1..99).to_i }
    kind { %w[goblin orc demon dragon].sample }
  end
end
