class BookingsController < ApplicationController
  include BookingsHelper

  def new
    @event = Event.find(params[:event_id])
    unless @event.user == current_user
      @booking = Booking.new
      @bookings = Booking.where("event_id = #{@event.id}")
      if @bookings.count == @event.size
        flash[:notice] = 'Event is full you are unable to join at the moment'
      else
        unless previous_booking?
          save_booking
          options = { user: current_user, event: @event }
          booking_emails(options)
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
    @booking = @bookings.select { |booking| booking.user == current_user }
    @booking.first.destroy if @booking.length != 0
    redirect_to '/events'
  end
end
