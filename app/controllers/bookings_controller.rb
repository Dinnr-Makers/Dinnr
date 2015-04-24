class BookingsController < ApplicationController
  include BookingsHelper

  def new
    @event = Event.find(params[:event_id])
    new_booking if @event.user != current_user
    unless previous_booking?
      save_booking
      options = { user: current_user, event: @event }
      booking_emails(options)
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
