class Album < ActiveRecord::Base
  
  belongs_to          :user
  has_many            :photos, :dependent => :destroy
  has_many            :comments, :as => :commentable
  
  #attr_accessible     :title, :description, :cover_id
  
  validates_presence_of :title, :description
  
  accepts_nested_attributes_for :photos, :allow_destroy => true
end
