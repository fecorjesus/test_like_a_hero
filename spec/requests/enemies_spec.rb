require 'rails_helper'

RSpec.describe "Enemies", type: :request do
  #index
  describe "GET /enemies" do
    it "returns http success status" do
      get enemies_path
      expect(response).to have_http_status(200)
    end
  end

  #create
  describe "POST /enemies" do
    context "when it has valid parameters" do
      let(:valid_attributes) { attributes_for(:enemy) }

      it "creates a new enemy" do
        expect {
          post enemies_path, params: valid_attributes.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
        }.to change(Enemy, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end
  end

  #show
  describe "SHOW /enemy/:id" do
    it "Show details of enemy by Id" do
        enemy = create(:enemy)
        get enemy_path(enemy) 
        expect(response).to have_http_status(:success)
        expect(response.body).to include(enemy.name, enemy.power_base.to_s, enemy.power_step.to_s, enemy.level.to_s)
      end
  end 
  
  # Edit
  describe "PUT /enemies" do
    context 'when the enemy exists' do
      let(:enemy) { create(:enemy)}
      let(:enemy_attributes) { attributes_for(:enemy)}

      before(:each) do
          put "/enemies/#{enemy.id}", params: { enemy: enemy_attributes }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      end


      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'updates the record' do
        expect(enemy.reload).to have_attributes(enemy_attributes)  
      end

      it 'returns the enemy updates'do
        expect(enemy.reload).to have_attributes(JSON.parse(response.body).except('created_at', 'updated_at')) 
      end
    end
  
    context "whe the enemy does not exist" do
      before(:each) { put '/enemies/0', params: attributes_for(:enemy)}

      it 'returns status code 404' do
        expect(response).to have_http_status(404) 
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Enemy with 'id'=#{0}/) 
      end
    end
  end
  
  # Destroy
  describe "DELETE /enemies" do
    context "when the enemy exists" do
      let(:enemy) { create(:enemy) }
      before(:each) { delete "/enemies/#{enemy.id}"} 

      it "returns status code 204" do
      expect(response).to have_http_status(204)
      end

      it "destroy the record" do
        expect{enemy.reload}.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context "when the enemy does not exist" do
      before(:each) { delete "/enemies/0" }
      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end
      it "returns a not found message" do
        expect(response.body).to match(/Couldn't find Enemy with 'id'=#{0}/) 
      end
    end
  end


end
