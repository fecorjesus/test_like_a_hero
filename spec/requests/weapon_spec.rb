require 'rails_helper'

RSpec.describe "Weapons", type: :request do
  describe "GET /weapons" do
    it "returns http success status" do
      get weapons_path
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get weapons_path
      expect(response).to render_template(:index)
    end

    it "displays the list of weapons" do
      weapons = create_list(:weapon, 3)
      get weapons_path

      weapons.each do |weapon|
        expect(response.body).to include(weapon.name, weapon.current_power.to_s, weapon.title)
        expect(response.body).to include("href=\"#{weapon_path(weapon)}\"")
      end
    end
  end

  describe "POST /weapons" do
    context "when it has valid parameters" do
      it "creates the weapon with correct attributes" do
        weapon_attributes = FactoryBot.attributes_for(:weapon)
        post weapons_path, params:{ weapon: weapon_attributes}
        expect(Weapon.last).to have_attributes(weapon_attributes)  
      end
    end

    context "when it has no valid parameters" do
      it "does not create weapon" do
        expect {
          post weapons_path, params: { weapon: { name: '', description: '', power_base: '', power_step: '', level: '' }}
        }.to_not change(Weapon, :count)
      end
    end
  end

  describe "SHOW /weapon/:id" do
    it "Show details of weapon by Id" do
        weapon = create(:weapon)
        get weapon_path(weapon) # Certifique-se de passar o objeto Weapon, não o ID
        expect(response).to have_http_status(:success)
        expect(response.body).to include(weapon.name, weapon.description, weapon.power_base.to_s, weapon.power_step.to_s, weapon.level.to_s)
      end
  end 

  describe "DESTROY /weapon/:id" do
    it "Delete the weapon by id" do
      weapon = create(:weapon)
      expect {
        delete weapon_path(weapon)
      }.to change(Weapon, :count).by(-1)
      expect(response).to redirect_to(weapons_path)
      follow_redirect!
      expect(response.body).to_not include(weapon.name)
    end
  end


end
