require "pact/provider/rspec"
require_relative "../lib/app"

Pact.service_provider "UserService" do
  honours_pact_with "UserApiClient" do
    pact_uri "../consumer/spec/pacts/userapiclient-userservice.json"
  end
end

Pact.provider_states_for "UserApiClient" do
  provider_state "a user with ID 1 exists" do
    set_up do
      USERS[1] = { id: 1, name: "Samara Morgan" }
    end

    tear_down do
      USERS.delete(1)
    end
  end

  provider_state "a user with ID 999 does not exist" do
    set_up do
      USERS.delete(999) # Ensure user 999 does not exist
    end
  end
end
