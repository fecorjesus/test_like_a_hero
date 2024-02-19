require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    it "returns success status" do
      get users_path
      expect(response).to  have_http_status(200)
    end
    it "the user`s title is present" do
      users = create_list(:user, 3)

      get users_path

      users.each do |user|
          expect(response.body).to include(user.title)     
      end
    end
  end

  describe "POST /users" do
    context "when it has valid parameters" do
      it "creates the user with correct attributes" do
       # Generate a hash of attributes for a new user
       user_attributes = FactoryBot.attributes_for(:user)
       # Perform a POST request to the route with the user attributes
       post users_path, params:{ user: user_attributes}
       # Verify if the user has the correct attributes
       expect(User.last).to have_attributes(user_attributes)
      end
    end

    context "whe it has no valid parameters" do
      it "does not create user" do
        expect{
          post users_path, params: { user: {kind: '', name: '', level: ''}}
         }.to_not change(User, :count)
      end
    end
  end
end
