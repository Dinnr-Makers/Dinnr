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
end

