require 'spec_helper'

describe 'GET /v1/events/:id' do
  it 'returns an event by id' do
    user = create(:user)
    event = create(:event, owner: user)

    get "/v1/events/#{event.id}"

    expect(to_json(response)).to eq({
      'address' => event.address,
      'ended_at' => event.ended_at.as_json,
      'id' => event.id,
      'lat' => event.lat,
      'lon' => event.lon,
      'name' => event.name,
      'started_at' => event.started_at.as_json,
      'owner' => {
        'id' => event.owner.id
      }
    })
  end
end
