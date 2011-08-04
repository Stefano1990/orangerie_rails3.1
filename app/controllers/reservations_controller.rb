class ReservationsController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    @reservation = Reservation.new(params[:reservation])
    @reservation.user = current_user
    @reservation.event = @event
    if @reservation.save
      flash[:success] = "You have made a reservation for this event."
      Invite.make_wall_post(@event, current_user)
      redirect_to :back
    else
      flash[:error] = "Your reservation could not be made."
      redirect_to :back
    end
  end
end
