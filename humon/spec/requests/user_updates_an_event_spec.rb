require "rails_helper"

describe "POST /v1/events" do
  it "creates an event with latitude, longitude, name, and started at date" do
    event = create(:event, name: 'Old name')


    new_name = 'New name'

    patch "/v1/events/#{event.id}", {
      address: event.address,
      ended_at: event.ended_at,
      lat: event.lat,
      lon: event.lon,
      name: new_name,
      owner: {
        id: event.owner.id
      },
      started_at: event.started_at
    }.to_json,
    set_headers(event.owner.device_token)

    event.reload
    expect(event.name).to eq new_name
    expect(to_json(response)).to eq({ 'id' => event.id })
  end

  it 'returns an error message when invalid' do
    event = create(:event)

    patch "/v1/events/#{event.id}", {
       address: event.address,
       ended_at: event.ended_at,
       lat: event.lat,
       lon: event.lon,
       name: nil,
       owner: {
         id: event.owner.id
       },
       started_at: event.started_at
     }.to_json,
     set_headers(event.owner.device_token)

     event.reload
     expect(event.name).to_not be nil
     expect(to_json(response)).to eq({
       'message' => 'Validation Failed',
       'errors' => [
         "Name can't be blank"
       ]
     })
     expect(response.code.to_i).to eq 422
   end
end