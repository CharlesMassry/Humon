require "rails_helper"

describe "POST /v1/events" do
  it "creates an event with latitude, longitude, name, and started at date" do
    date = Time.zone.now
    device_token = SecureRandom.urlsafe_base64
    owner = create(:user, device_token: device_token)

    post '/v1/events', {
      address: '123 Example St.',
      ended_at: date,
      lat: 1.0,
      lon: 1.0,
      name: "Fun Place!",
      started_at: date,
      owner: {
        id: owner.id
      }
    }.to_json, set_headers(device_token)

    event = Event.last

    expect(to_json(response)).to eq({ 'id' => event.id })
    expect(event.address).to eq '123 Example St.'
    expect(event.ended_at.to_i).to eq date.to_i
    expect(event.lat).to eq 1.0
    expect(event.lon).to eq 1.0
    expect(event.name).to eq 'Fun Place!'
    expect(event.started_at.to_i).to eq date.to_i
    expect(event.owner).to eq owner
  end

  it "returns an error message when invalid" do
    device_token = SecureRandom.urlsafe_base64

    post '/v1/events', {}.to_json, set_headers(device_token)

    expect(to_json(response)).to eq({
      'message' => 'Validation Failed',
      'errors' => [
        "Name can't be blank",
        "Lat can't be blank",
        "Lon can't be blank",
        "Started at can't be blank"
      ]
    })
    expect(response.code.to_i).to eq 422
  end
end