class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable, :timeoutable and :oauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  attr_accessor :relevance_rating
  
  #validates_presence_of [:email, :password, :password_confirmation]
  validates_length_of :name, :within => 3..30
  validates_presence_of :name
  
  NOT_DELETED = [%(deleted = ?), false]
  REQUESTED_AND_ACTIVE =  [%(status = ?), Connection::REQUESTED]
  ACCEPTED = [%(status = ? AND trusted = ?), Connection::ACCEPTED, true]
  FEED_SIZE = 100
  TRASH_TIME_AGO = 1.month.ago
  MESSAGES_PER_PAGE = 20
  
  before_create  {|user| user.build_infos(self)}
  
  #named_scope :unapproved_requests, where({:user_id => self, :approved => false})

  has_many :connections
  has_many :posts, :dependent => :destroy
  has_many :wall_posts, :class_name => "Post", :foreign_key => "wall_id", :order => 'created_at DESC'
  has_many :invites, :class_name => "Invite", :foreign_key => "contact_id", :order => 'created_at DESC'
  
  has_many :contacts, :through => :connections, :order => 'users.created_at DESC', :conditions => ACCEPTED 
  has_many :requested_contacts, :through => :connections,
             :source => :contact,
             :conditions => REQUESTED_AND_ACTIVE
  
  # not used currently.
  # has_many :online_contacts, :source => :contact, :through => :connections, 
  #                            :conditions => [ "current_sign_in_at >= ?", 30.minutes.ago ]
  has_one :infos
  
  has_many :livestreams
                                        
  # trying to replace with notifications
  has_many :notifications
                                        
  has_many :activities, :through => :livestreams, :dependent => :destroy 
  
  has_many :sent_messages, :class_name => "Message", :foreign_key => "sender_id", 
                           :conditions => "sender_deleted_at IS NULL", :dependent => :destroy, 
                           :order => "created_at DESC" 
  has_many :recieved_messages, :class_name => "Message", :foreign_key => "recipient_id", 
                            :conditions => "recipient_deleted_at IS NULL", :dependent => :destroy, 
                            :order => "created_at DESC" 

  has_many :created_conversations, :class_name => "Conversation", :foreign_key => "sender_id"
  has_many :recieved_conversations, :class_name => "Conversation", :foreign_key => "recipient_id"
  
  # photos and albums
  has_many  :albums
  has_many  :photos, :through => :albums
  
  # searches
  has_many  :searches
  
  # chats
  has_many  :chatmessages, :dependent => :destroy 
  
  # avatar
  has_one   :avatar, :foreign_key => "avatar_id", :class_name => "Photo"
  has_many  :reservations 
  
  attr_reader :per_page
    @@per_page = 10
    
  accepts_nested_attributes_for :infos
  
  def common_contacts_with(friend)
    contacts & friend.contacts
  end
  
  def trusted?
    trusted
  end
  
  ## avatar method 
  # TODO: this is just a temporary hack i think..
  def avatar
    avatar_id.nil? ? Photo.last : Photo.find(avatar_id)
  end
    
  ## Message methods
  def trashed_messages(page = 1)
    conditions = [%((sender_id = :user AND sender_deleted_at > :t) OR
                    (recipient_id = :user AND recipient_deleted_at > :t)),
                  { :user => id, :t => TRASH_TIME_AGO }]
    order = 'created_at DESC'
    trashed = Message.paginate(:all, :conditions => conditions,
                                     :order => order,
                                     :page => page,
                                     :per_page => MESSAGES_PER_PAGE)
  end
  
  ## returns the number of persons for a user. i.e couple = 2, male/female = 1
  def persons
    if self.infos.sex == "Couple"
      2
    else
      1
    end
  end
  
  # this function enables human friendly URLs for the user model.
  def to_param
    "#{id}-#{name}".downcase.gsub(/\W+/, "-").gsub(/^[-]+|[-]$/,"").strip
  end
  
  # This makes the "stream" for the user wall.
  # At the moment this includes:
  # -> Posts
  # -> Invites
  # Can be extended later if needed.
  def make_stream(offset=0)
    # awesome function..
    # any object can be added to the stream and then the stream sorts itself automatically. so pretty and simple :)
    stream = wall_posts
    stream.limit(10).offset(offset)
  end
  
  def stream
    Post.where('posts.wall_id = ?', id).joins(:invites).where('invites.user_id = ?', id)
    #:stream, lambda{|user| joins(:posts).where('posts.wall_id = ?', user.id).joins(:invites).where('invites.user_id = ?', user.id)}
  end
  
  def make_livestream(offset=0)
    livestream = livestreams.limit(10).offset(offset)
  end
  
  class << self
    def relevance_rating(user1, user2)
      user1_infos = user1.infos
      user2_infos = user2.infos
      rating = 0
      
      unless relevant_age(user1).nil? or relevant_age(user2).nil? # in case a profile doesnt have the age filled out.
        if (user1_infos.sex == "Male" and user2_infos.sex == "Male")
          rating = 10
        end
      
        if (user1_infos.sex == "Male" and user2_infos.sex == "Female") || (user1_infos.sex == "Female" and user2_infos.sex == "Male")
          rating = 50
        end
      
        if (user1_infos.sex == "Male" and user2_infos.sex == "Couple") || (user1_infos.sex == "Couple" and user2_infos.sex == "Male")
          rating = 20
        end
      
        if (user1_infos.sex == "Female" and user2_infos.sex == "Female")
          rating = 30
        end
      
        if (user1_infos.sex == "Couple" and user2_infos.sex == "Couple")
          rating = 50
        end
      
        rating += 5 if (relevant_age(user1) - relevant_age(user2)).magnitude.round >= 16
        rating += 10 if (relevant_age(user1) - relevant_age(user2)).magnitude.round >= 10
        rating += 20 if (relevant_age(user1) - relevant_age(user2)).magnitude.round >= 5
        rating += 30 if (relevant_age(user1) - relevant_age(user2)).magnitude.round >= 0
      
      
        if (self.contacts_in_common(user1, user2))*2 > 20
          rating += 20
        else
          rating += self.contacts_in_common(user1, user2)*2
        end
      
        # random factor to spice shit up a little :D
        rating *= (0.6 + rand.round(1)*0.3)
        return rating.round
      else
        rating = 1
        return rating
      end
    end
    
    def contacts_in_common(user1, user2)
      user1_contacts = user1.contacts
      user2_contacts = user2.contacts
      return (user1_contacts & user2_contacts).count
    end
    
    def relevant_age(user)
      user_age = user.infos.age_m if user.infos.sex == "Male"
      user_age = user.infos.age_f if user.infos.sex == "Female"
      user_age = ((user.infos.age_f+user.infos.age_m)/2) if user.infos.sex == "Couple"
      return user_age
    end
  end
end