class Api::V1::EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(event_params)
    unless @event.save
      render json: {
        message: "Validation Failed",
        errors: @event.errors.full_messages
      }, status: 422
    end
  end

  def update
    @event = Event.find(params[:id])
    unless @event.update(event_params)
      render json: {
        message: "Validation Failed",
        errors: @event.errors.full_messages
      }, status: 422
    end
  end

  private
  def event_params
    {
      address: params[:address],
      ended_at: params[:ended_at],
      lat: params[:lat],
      lon: params[:lon],
      name: params[:name],
      started_at: params[:started_at],
      owner: current_user
    }
  end
end