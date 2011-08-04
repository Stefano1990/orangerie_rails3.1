class Post < ActiveRecord::Base
  extend ActivityLogger
  include Flagger
  
  belongs_to :user
  belongs_to :owner, :class_name => "User", :foreign_key => "wall_id"
  has_one :wall_item, :as => :item
  
  has_many    :comments, :as => :commentable, :dependent => :destroy
  has_one     :flag, :as => :flaggable, :dependent => :destroy
  
  # association for the livestreams and feeds
  has_many :activities, :foreign_key => "item_id", :dependent => :destroy,
                          :conditions => "item_type = 'Post'"
  
  validates_presence_of :body, :message => "can't be blank"
  validates_length_of :body, :within => 2..600, :message => "between 3-600 letters"
  
  default_scope order('created_at DESC')
end
