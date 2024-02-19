
FactoryBot.define do
    factory :weapon do
        name {FFaker::Game.to_s}
        description { FFaker::Game.title}
        power_base { (FFaker::Random.rand(3..10) * 1000)}
        power_step { (FFaker::Random.rand(1..9) * 100)}
        level { FFaker::Random.rand(1..99)}
    end
end
