class ReservationObserver < ActiveRecord::Observer
  def after_save(reservation)
    # Doesnt strictly have anything to do with the actual post, therefore its in the activity observer.
    activity = Activity.create!(:item => reservation, :user => reservation.user)
  end
end