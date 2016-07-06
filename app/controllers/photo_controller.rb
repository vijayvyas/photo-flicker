class PhotoController < ApplicationController
  def index
    @photos = Photo.all
  end

  def show
    @photo = Photo.find(params[:id])
    @comment = @photo.comments.build
  end
end
