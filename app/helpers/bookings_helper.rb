module BookingsHelper
  def save_booking
    @booking.user = current_user
    @booking.event = @event
    @booking.save
  end

  def booking_emails(options)
    JoinEventMailer.join_email(options).deliver_now
    JoinEventMailer.host_email(options).deliver_now
  end

  def previous_booking?
    @bookings.select { |booking| booking.user == current_user }.length == 1
  end

  def full_event_error
    flash[:notice] = 'Event is full you are unable to join at the moment'
  end

  def new_booking
    @booking = Booking.new
    @bookings = Booking.where("event_id = #{@event.id}")
    full_event_error if @bookings.count == @event.size
  end
end

