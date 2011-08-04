class Admin::PagePhotosController < ApplicationController
  layout "admin"
  
  def new
    @page_photo = PagePhoto.new
    @page_photo.page = Page.find(params[:page_id])
  end
  
  def index
    @page = Page.find(params[:page_id])
  end
  
  def create
    @page_photo = PagePhoto.new(params[:page_photo])
    @page_photo.page = Page.find(params[:page_id])
    if @page_photo.save
      flash[:success] = "awesome."
      redirect_to admin_page_page_photos_path(@page_photo.page)
    else
      flash[:error] = "not so awesome."
      redirect_to admin_page_page_photos_path(@page_photo.page)
    end
  end
end
