class Admin::ReservationsController < ApplicationController
  layout "admin"
  
  def index
    @event = Event.find(params[:event_id])
    @reservations = @event.reservations
  end
  
  def printview
    @event = Event.find(params[:event_id])
    @reservations = @event.reservations
    render 'printview', :layout => "print"
  end
end
