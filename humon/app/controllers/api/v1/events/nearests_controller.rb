class Api::V1::Events::NearestsController < ApplicationController
  def index
    @events = Event.near(
      [params[:lat], params[:lon]],
      params[:radius],
      units: :km
    )
    if @events.empty?
      render json: {
        message: 'No Events Found'
      }
    end
  end
end