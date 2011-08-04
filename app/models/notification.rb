class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :contact, :foreign_key => "contact_id", :class_name => "User" 
  belongs_to :item, :polymorphic => true
  
  default_scope order('created_at DESC')
  
  class << self
    def set_conversation_notifications(conversation)
      conversation.each do |message|
        message.notification.update_attributes(:read => true)
      end
    end
  end
end
