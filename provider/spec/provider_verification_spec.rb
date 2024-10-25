require "pact_helper"

RSpec.describe "Pact verification", pact: true do
  it "verifies the pact between UserApiClient and UserService" do
    # The pact verification will run automatically based on the pact_helper configuration.
  end
end
