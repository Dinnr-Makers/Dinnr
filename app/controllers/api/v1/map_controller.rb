class API::V1::MapController < ApplicationController
  def index
    @events = Event.all.where.not("longitude" => nil)
    @pictures = Eventpicture.all
  end

  def show
    @event = Event.find(params[:event_id])
    @eventpictures = Eventpicture.where("event_id" => params[:event_id])
    @pictures = @eventpictures.map{|ep| ep.picture_id}.map{|picture| Picture.find(picture)}
  end
end