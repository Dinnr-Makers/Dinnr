class API::V1::MapController < ApplicationController
  
  
  def index
    @events = Event.mappable_events
  end

  def show
    @event = Event.find(params[:event_id])
  end
end
