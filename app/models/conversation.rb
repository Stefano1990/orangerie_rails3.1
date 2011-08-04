class Conversation < ActiveRecord::Base
  belongs_to :sender, :class_name => "User", :foreign_key => "sender_id"
  belongs_to :recipient, :class_name => "User", :foreign_key => "recipient_id"
  has_many :messages
  
  scope :conversations_for_user, lambda {|user| {:conditions => ["sender_id = :user OR recipient_id = :user", :user => user] }}
  
  def new_messages?(user)
    !messages.where(:recipient_id => user, :recipient_read_at => nil ).empty?
  end
  
  def not_trashed_messages(user)
    messages.where("(sender_id = :user AND sender_deleted_at is NULL) OR (recipient_id = :user AND recipient_deleted_at is NULL)",
                    :user => user.id).reverse
  end
  
  def other_user(user)
    user == sender ? recipient : sender
  end
  
  private
end
