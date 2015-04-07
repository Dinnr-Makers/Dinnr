class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def new
  end

  def create
    Event.create(event_params)
    redirect_to '/events'
  end

  def event_params
    params.require(:event).permit(:title, :description, :location, :date, :size)
  end

end
