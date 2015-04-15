class PicturesController < ApplicationController


  def index
    @picture = Picture.new
    @pictures = Picture.all
    @pictures = @pictures.select{|p| p.user_id == current_user.id}
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.new(picture_params)
    @picture.user = current_user
    if @picture.save
      redirect_to :back
    else
      render 'new'
    end
  end

  def picture_params
    params.require(:picture).permit(:title, :image)
  end

  def show
    @picture = Picture.find(params[:id])
  end

  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy
    flash[:notice] = 'Picture deleted successfully'
    redirect_to '/pictures'
  end

  def library
    @picture = Picture.new
    @event = Event.find(params[:event_id])
    @pictures = current_user.pictures
  end

end
