class Livestream < ActiveRecord::Base
  belongs_to :activity
  belongs_to :user
  
  accepts_nested_attributes_for :activity, :allow_destroy => true
  
  # This would check that there is only 1 livestream row for an activity for a given user.
  # The problem is, that this validation increases the time to insert the livestream by at least 5 times..
  # For performance reasons this is commented out. If it IS needed, it can be activated by uncommenting it.
  # Much love.
  # validates_uniqueness_of :activity_id, :scope => :user_id
  
  default_scope order('id DESC')
end