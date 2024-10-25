
# User API Client - Pact Demo

This project demonstrates **Pact** contract testing between a **consumer** (`UserApiClient`) and a **provider** (`UserService`). It ensures that both services adhere to the agreed contract through automated tests.

## Prerequisites

Ensure you have the following installed:  

- **Ruby 3.2.2**  
- **Bundler**: Install it with:  
  ```bash
  gem install bundler
  ```  
- **Pact Gem**: Automatically installed through `bundle install`.

---

## Running the Provider Service

Start the provider app using `rackup`:  
```bash
bundle exec rackup --port 4567
```
The service will be available at:  
`http://localhost:4567`

---

## Running Consumer Tests

1. **Verify Consumer (Mock) Tests**:  
   ```bash
   bundle exec rspec spec/user_api_client_spec.rb
   ```
      A Pact contract will be generated at:  
   ```
   consumer/spec/pacts/userapiclient-userservice.json
   ```

2. **Expected Scenarios**:  
   - **User exists**: Returns status `200` with user details.
   - **User does not exist**: Returns status `404` with an error message.

---

## Verifying the Provider Against the Pact

1. **Start the Provider Service** (if not already running):
   ```bash
   bundle exec rackup --port 4567
   ```

2. **Verify the Provider with the Pact**:
   ```bash
   rake pact:verify
   ```

   This checks if the `UserService` provider complies with the expectations defined in the Pact file.

---