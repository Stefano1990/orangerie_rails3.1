class Admin::SeriesController < ApplicationController
  layout "admin"
  
  def index
    @series = Series.all
  end
  
  def new
    @series = Series.new
  end
  
  def create
    @series = Series.create(params[:series])
    if @series.save
      flash[:success] = "Event series created."
      redirect_to admin_series_index_path
    else
      flash[:error] = "Event series could not be created."
      render :new
    end
  end
  
  def edit
    @series = Series.find(params[:id])
  end
  
  def update
    @series = Series.find(params[:id])
    if @series.update_attributes(params[:series])
      flash[:success] = "Event series has been updated."
      redirect_to admin_series_index_path
    else
      flash[:error] = "Event series has not been updated."
      render :edit
    end
  end
  
  def destroy
    @series = Series.find(params[:id])
    if @series.destroy
      flash[:success] = "Event series has been deleted."
      redirect_to admin_series_index_path
    else
      flash[:error] = "Event series has not been deleted."
      redirect_to admin_series_index_path
    end
  end
end
