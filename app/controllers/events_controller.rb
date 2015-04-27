class EventsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show, :map]
  include EventsHelper

  def index
    @events = Event.order(:date)
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
    @event.user == current_user ? @display_edit = true : @display_edit = false
    get_guests_and_pictures
    @comments = @event.comment_threads.order('created_at desc')
    @new_comment = Comment.build_from(@event, current_user.id, "") if current_user
  end

  def edit
    @event = Event.find(params[:id])
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
    end
  end

end