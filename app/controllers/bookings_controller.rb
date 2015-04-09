class BookingsController < ApplicationController

  def new
    @event = Event.find(params[:event_id])

    if @event.user == current_user
      flash[:notice] = "You cannot join your own event"
    else
      @booking = Booking.new
      @bookings = Booking.where("event_id = #{@event.id}")
      @previous_booking = @bookings.select{|booking| booking.user == current_user}
      if @previous_booking.length == 1
        flash[:notice] = "You have already joined this event"
      else
        @booking.user = current_user
        @booking.event = @event
        @booking.save
      end
    end
    redirect_to "/events/#{@event.id}"
  end

  def edit
  end

  def leave
    @event = Event.find(params[:event_id])
    @bookings = Booking.where("event_id = #{@event.id}")
    @booking = @bookings.select{|booking| booking.user == current_user}
    if @booking.length == 0
      flash[:notice] = "You have not joined this event yet"
    else
      @booking.first.destroy
    end
    redirect_to "/events"
  end

end
