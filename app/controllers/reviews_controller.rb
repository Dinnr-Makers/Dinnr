class ReviewsController < ApplicationController

  def new
    @event = Event.find(params[:event_id])
    @review = Review.new
  end

  def create
    @event = Event.find(params[:event_id])
    @review = Review.new(review_params)
    @review.user = current_user
    @review.event_id = @event.id
    @review.save
    redirect_to "/events/#{@event.id}"
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

  def edit
    @event = Event.find(params[:event_id])
    event_reviews = Review.all.select{|review|review.event_id == @event.id}.select{|review|review.user_id == current_user.id}
    @review = event_reviews.first
  end

  def update
    @review = Review.find(params[:id])
    @event = Event.find(@review.event_id)
    @review.update(review_params)
    redirect_to "/events/#{@event.id}"
  end

end
