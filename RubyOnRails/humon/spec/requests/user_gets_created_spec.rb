require "rails_helper"

describe "POST /v1/users" do
  it "successfully creates a user" do
    device_token = SecureRandom.urlsafe_base64

    post '/v1/users', {}, set_headers(device_token)

    expect(User.last.device_token).to eq(device_token)
  end
end
