class BookingsController < ApplicationController

  def new
    @event = Event.find(params[:event_id])
    @booking = Booking.new
    @booking.user = current_user
    @booking.event = @event
    @booking.save
    redirect_to "/events/#{@event.id}"
  end

end
