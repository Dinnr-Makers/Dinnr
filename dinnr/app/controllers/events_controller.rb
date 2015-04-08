class EventsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]

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
    params.require(:event).permit(:title, :description, :location, :date, :size)
  end

  def show
    @event = Event.find(params[:id])
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

  def join
    @event = Event.find(params[:id])
    flash[:notice] = "#{current_user.email} has joined #{@event.title}"
    redirect_to :back
  end

end
