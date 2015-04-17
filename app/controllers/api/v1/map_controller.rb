class API::V1::MapController < ApplicationController
  
  
  def index
    @events = Event.mappable_events.order(:date)
  end

  def show
    @event = Event.find(params[:event_id])
  end
end
