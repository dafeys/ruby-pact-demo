require "net/http"
require "json"

class UserApiClient
  def initialize(base_url)
    @base_url = base_url
  end

  def get_user(user_id)
    uri      = URI("#{@base_url}/users/#{user_id}")
    response = Net::HTTP.get_response(uri)

    case response.code.to_i
    when 200
      JSON.parse(response.body)
    when 404
      raise StandardError, "User not found"
    else
      raise StandardError, "Unexpected error"
    end
  end
end
