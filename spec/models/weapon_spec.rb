require 'rails_helper'

RSpec.describe Weapon, type: :model do
  it "returns the weapon current power" do
    weapon = build(:weapon)
    expected_power = weapon.power_base + ((weapon.level - 1) * weapon.power_step)
    expect(weapon.current_power).to eq(expected_power)
  end

  it "returns the correct hero title" do
    name = FFaker::Game
    level = FFaker::Random.rand(1..99)
    
    weapon = create(:weapon, name: name, level: level)

    expect(weapon.title).to eq("#{name} ##{level}")
  end
end
