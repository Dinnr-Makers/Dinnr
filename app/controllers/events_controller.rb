class EventsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show, :map]

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event =  Event.new(event_params)
    @event.user = current_user
    if @event.save
      redirect_to '/events'
    else
      render 'new'
    end
  end

  def event_params
    params.require(:event).permit(:title, :description, :location, :date, :time, :size, :housenumber, :street, :city, :country, :postcode)
  end

  def show
    @event = Event.find(params[:id])
    @bookings = Booking.where("event_id = #{@event.id}")
    @guests = @bookings.map{|booking| booking.user_id}.map{|guest| User.find(guest)}
  end

  def edit
    @event = Event.find(params[:id])
    unless @event.user == current_user
      flash[:notice] = 'You can only edit events that you have created'
      redirect_to '/events'
    end
  end

  def update
    @event = Event.find(params[:id])
    @event.update(event_params)
    redirect_to '/events'
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.user == current_user
      @event.destroy
      flash[:notice] = 'Event deleted successfully'
      redirect_to '/events'
    else
      flash[:notice] = 'You can only delete events that you have created'
      redirect_to '/events'
    end
  end

  def map
    @events = Event.all.where.not("longitude" => nil)
  end

end
