class Reservation < ActiveRecord::Base
  belongs_to              :user
  belongs_to              :event

  # association for the livestreams and feeds
  has_many                :activities, :foreign_key => "item_id", :dependent => :destroy,
                          :conditions => "item_type = 'Reservation'"
                          
  attr_accessible         :guests_male, :guests_female, :remarks
                          
  validates               :user_id, :event_id, :presence => true
  validates_uniqueness_of :user_id, :scope => :event_id # checks that there is only one reservation for an event per user.
  
  scope                   :upcoming, lambda {|user| where("reservations.user_id = ?", user.id).
                                    joins(:event).
                                    where("events.date >= ?", Time.now)}
                                    

end
