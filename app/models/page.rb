class Page < ActiveRecord::Base  
  SPECIAL_PAGES = ["guestbook", "contacts"]
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :title, :content, :is_commentable, :category_id, :lang
  
  validates_presence_of [:title, :content]
  validates_length_of   :title, :within => 3..50 
  
  # relationships
  belongs_to      :category
  has_many        :comments, :as => :commentable
  has_many        :page_photos

  def language
    self.lang
  end
  
  # this function enables human friendly URLs for the model
  def to_param
    "#{id}-#{title}".downcase.gsub(/\W+/, "-").gsub(/^[-]+|[-]$/,"").strip
  end
end
