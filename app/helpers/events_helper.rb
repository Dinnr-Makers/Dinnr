module EventsHelper

  def get_guests_and_pictures
    @guests = Booking.where("event_id = #{@event.id}").map{|booking| booking.user_id}.map{|guest| User.find(guest)}
    @pictures = Eventpicture.where("event_id = #{@event.id}").map{|ep| ep.picture_id}.map{|picture| Picture.find(picture)}
  end
end
