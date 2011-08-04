class EventsController < ApplicationController
  def index
    if params[:series_id].nil?
      @upcoming_events = Event.upcoming
      @events_today = Event.today
      @past_events = Event.past
    else
      @series = Series.find(params[:series_id]) || Series.first
      @events = @series.events
    end 
  end
  
  def show
    @event = Event.find(params[:id])
    @friends_not_coming = Invite.friends_not_coming(@event, current_user) # puts all the friends not coming into the variable to populate the popup form.
  end
  
  def reviews
    @events = Event.where(:is_review => true)
  end
end
