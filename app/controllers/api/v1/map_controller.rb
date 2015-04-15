class API::V1::MapController < ApplicationController
  
  
  def index
    # @events = Event.where.not("longitude" => nil)
    # attach_pics_to_each_of(@events)
    @events = Event.mappable_events
  end

  def show
    @event = Event.find(params[:event_id])
    @eventpictures = Eventpicture.where("event_id" => params[:event_id])
    @pictures = @eventpictures.map{|ep| ep.picture_id}.map{|picture| Picture.find(picture)}
  end
end



def attach_pics_to_each_of(events)
  events.each do |event|
    event.eventpictures = Eventpicture.all.where("event_id" => event.id).map{|ep| ep.picture_id}.map{|pic|Picture.find(pic)}
  end
end