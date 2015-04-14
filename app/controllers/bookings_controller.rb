class BookingsController < ApplicationController

  def new
    @event = Event.find(params[:event_id])
    unless @event.user == current_user
      @booking = Booking.new
      @bookings = Booking.where("event_id = #{@event.id}")
      if @bookings.count == @event.size
        flash[:notice] = "Event is full you are unable to join at the moment"
      else
        @previous_booking = @bookings.select{|booking| booking.user == current_user}
        unless @previous_booking.length == 1
          @booking.user = current_user
          @booking.event = @event
          @booking.save
        end
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
