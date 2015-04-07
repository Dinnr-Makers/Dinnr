class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    Event.create(event_params)
    redirect_to '/events'
  end

  def event_params
    params.require(:event).permit(:title, :description, :location, :date, :size)
  end

  def show
    @event = Event.find(params[:id])
  end

end
