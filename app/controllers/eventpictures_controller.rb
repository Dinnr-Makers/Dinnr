class EventpicturesController < ApplicationController

  def new
    @eventpicture = Eventpicture.new
    @picture = Picture.find(params[:picture_id].to_i)
    @eventpicture.picture_id = @picture.id
    @event = Event.find(params[:event_id].to_i)
    @eventpicture.event_id = @event.id
    @eventpicture.save
    redirect_to "/events/#{@event.id}"
  end

end
