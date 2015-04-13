class API::V1::MapController < ApplicationController
  def index
    @events = Event.all.where.not("longitude" => nil)
  end

  def show
    @event = Event.find(params[:event_id])
  end
end