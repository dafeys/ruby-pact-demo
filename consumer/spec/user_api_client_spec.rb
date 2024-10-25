require "pact/consumer/rspec"
require "user_api_client"

Pact.service_consumer "UserApiClient" do
  has_pact_with "UserService" do
    mock_service :user_service do
      port 1234
    end
  end
end

Pact.describe UserApiClient, pact: true do
  let(:client) { described_class.new("http://localhost:1234") }
  let(:response) { client.get_user(1) }

  context "when the user exists" do
    before do
      user_service
        .given("a user with ID 1 exists")
        .upon_receiving("a request for user 1")
        .with(method: :get, path: "/users/1")
        .will_respond_with(
          status: 200,
          headers: { "Content-Type" => "application/json" },
          body: { id: 1, name: "Samara Morgan" }
        )
    end

    it "get user 1" do
      expect(response).to eq({ "id" => 1, "name" => "Samara Morgan" })
    end
  end

  context "when the user does not exist" do
    before do
      user_service
        .given("a user with ID 999 does not exist")
        .upon_receiving("a request for user 999")
        .with(method: :get, path: "/users/999")
        .will_respond_with(
          status: 404,
          headers: { "Content-Type" => "application/json" },
          body: { error: "User not found" }
        )
    end
  
    it "raises a StandardError when the user does not exist" do
      expect { client.get_user(999) }.to raise_error(StandardError, "User not found")
    end
  end
end