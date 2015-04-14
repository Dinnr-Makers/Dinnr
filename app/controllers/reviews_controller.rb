class ReviewsController < ApplicationController

  def new
    @event = Event.find(params[:event_id])
    @review = Review.new
  end

  def create
    @event = Event.find(params[:event_id])
    @event.reviews.create(review_params)
    redirect_to "/events/#{@event.id}"
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

end
