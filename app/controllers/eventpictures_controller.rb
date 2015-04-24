class EventpicturesController < ApplicationController
  def new
    @eventpicture = Eventpicture.new
    @eventpicture.picture_id = Picture.find(params[:picture_id].to_i).id
    @event = Event.find(params[:event_id].to_i)
    @eventpicture.event_id = @event.id
    @eventpicture.save
    redirect_to "/events/#{@event.id}"
  end

  def destroy
    @event = Event.find(params[:event_id].to_i)
    @eventpictures = Eventpicture.where("event_id = #{@event.id}")
    @picture = Picture.find(params[:picture_id].to_i)
    @eventpicture = @eventpictures.reject { |p| p.picture_id != @picture.id }
    @eventpicture.first.destroy
    redirect_to "/events/#{@event.id}"
  end
end
