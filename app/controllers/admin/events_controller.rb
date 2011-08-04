class Admin::EventsController < ApplicationController
  layout "admin"
  
  def index
    @upcoming_events = Event.upcoming
    @events_today = Event.today
    @past_events = Event.past
  end
  
  def show
    @event = Event.find(params[:id])
  end
  
  def edit
    @event = Event.find(params[:id])
  end
  
  def new
    @event = Event.new
  end
  
  def create
    @event = Event.create(params[:event])
    if @event.save
      flash[:success] = t('comments.flash.created') 
      respond_to do |format|
        format.html { redirect_to admin_events_path }
      end
    else
      flash[:error] = t('comments.flash.created_error')
      render :new
    end
  end
  
  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      flash[:success] = "Event has been updated."
      redirect_to admin_event_path(@event)
    else
      flash[:error] = "Event was not updated."
      render :edit
    end
  end
end
