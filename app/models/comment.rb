class Comment < ActiveRecord::Base
  extend ActivityLogger
  include Flagger
  
  belongs_to :commentable, :polymorphic => true
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  has_one    :flag, :as => :flaggable, :dependent => :destroy
  
  has_many :activities, :foreign_key => "item_id", :dependent => :destroy,
                          :conditions => "item_type = 'Comment'"
  
  attr_accessible :body
  
  validates_presence_of [:user_id, :commentable_id, :commentable_type, :body ], :message => "can't be blank"
  
  #after_create {|comment| Comment.log_activity(comment)}
  
  # Thinking sphinx stuff
  define_index do
    # fields
    indexes :body, :sortable => true

    indexes commentable_type, :as => :type
    #indexes commentable.user_id, :as => :commentable_user
    indexes user(:name), :as => :user
    indexes user(:id), :as => :user_id
    indexes commentable.title, :as => :commentable_title
    
    # attributes
    has :deleted, :created_at, :updated_at
  end
  
  private
  
  class << self
    # log the activity
    def log_activity(comment)
      activity = Activity.create!(:item => comment, :user => comment.user)
      add_activities(:activity => activity, :user => comment.user, :include_user => comment.user )
      #add_activities(:activity => activity, :user => comment.commentable.user)
    end
  end
end
