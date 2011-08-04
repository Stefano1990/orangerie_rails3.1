class Series < ActiveRecord::Base
  has_many          :events
  
  attr_accessible   :name
  validates         :name, :uniqueness => true, :presence => true, :length => { :within => 1..100 }
end
