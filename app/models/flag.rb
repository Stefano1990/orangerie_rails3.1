class Flag < ActiveRecord::Base
  belongs_to :flaggable, :polymorphic => true
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  
  # self explanatory
  validates_presence_of     :flaggable_type, :flaggable_id, :user_id
  
  # makes sure that a user can only flag something once. But enables multiple users to flag the same thing.
  validates_uniqueness_of   :flaggable_id, :scope => [:user_id]
end
