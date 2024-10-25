require "sinatra"
require "json"

# Shared in-memory store
USERS = {}

# Seed data for testing
USERS[1] = { id: 1, name: "Samara Morgan" }

# Route to get a user by ID
get "/users/:id" do
  content_type :json

  user = USERS[params[:id].to_i]
  if user
    user.to_json
  else
    status 404
    { error: "User not found" }.to_json
  end
end
